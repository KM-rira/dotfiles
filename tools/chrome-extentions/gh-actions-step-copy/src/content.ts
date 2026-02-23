(() => {
  const BUTTON_CLASS = "km-gh-copy-step-btn";

  function sleep(ms: number): Promise<void> {
    return new Promise((r) => setTimeout(r, ms));
  }

  function highlightErrorsInLogLine(element: Element): void {
    // 既に処理済みかチェック
    if (element.hasAttribute('data-error-highlighted')) {
      return;
    }
    element.setAttribute('data-error-highlighted', 'true');

    // エラーキーワードのパターン（大文字小文字を区別しない）
    const errorPatterns = [
      /\b(error|errors|err)\b/gi,
      /\b(fail|failed|failure|failing)\b/gi,
      /\b(fatal)\b/gi,
      /\b(panic|panicking)\b/gi,
      /\b(exception)\b/gi,
      /\b(cannot|can't)\b/gi,
      /\b(unable)\b/gi,
      /\b(invalid)\b/gi,
      /\b(not found|missing)\b/gi,
      /\b(undefined)\b/gi,
      /\b(unexpected)\b/gi,
      /\b(denied|permission denied)\b/gi,
      /\b(timeout|timed out)\b/gi,
    ];

    // テキストノードを走査して、エラーキーワードをハイライト
    const walkTextNodes = (node: Node) => {
      if (node.nodeType === Node.TEXT_NODE && node.textContent) {
        const text = node.textContent;
        let hasError = false;

        // いずれかのパターンにマッチするかチェック
        for (const pattern of errorPatterns) {
          if (pattern.test(text)) {
            hasError = true;
            break;
          }
        }

        if (hasError && node.parentElement) {
          console.log('[GH-Actions] Found error text:', text.trim());
          // テキストをハイライト処理
          const span = document.createElement('span');

          let html = text;
          for (const pattern of errorPatterns) {
            html = html.replace(pattern, (match) => {
              return `<span class="km-gh-error-highlight">${match}</span>`;
            });
          }

          span.innerHTML = html;
          node.parentElement.replaceChild(span, node);
        }
      } else if (node.nodeType === Node.ELEMENT_NODE) {
        // 既にハイライトされている場合はスキップ
        const el = node as Element;
        if (el.classList.contains('km-gh-error-highlight')) {
          return;
        }
        // 子ノードを再帰的に処理
        Array.from(node.childNodes).forEach(walkTextNodes);
      }
    };

    walkTextNodes(element);
  }

  function highlightErrorsInStep(stepEl: Element): void {
    // DETAILS要素を探す（ログはその中にネストされている）
    const detailsEl = stepEl.querySelector('details.js-checks-log-details');
    if (!detailsEl) {
      console.log('[GH-Actions] No details element found in step');
      return;
    }

    // ログ行を含む全ての要素を探す
    // GitHubのログは通常、div要素として表示される
    const logContainer = detailsEl.querySelector('.js-check-step-log-container, [class*="log"]');
    if (!logContainer) {
      console.log('[GH-Actions] No log container found');
      return;
    }

    console.log('[GH-Actions] Processing log container:', logContainer);

    // ログコンテナ内のすべてのテキストノードを走査
    const walkAndHighlight = (node: Node) => {
      if (node.nodeType === Node.TEXT_NODE && node.textContent && node.textContent.trim()) {
        highlightErrorsInLogLine(node.parentElement!);
      } else if (node.nodeType === Node.ELEMENT_NODE) {
        const el = node as Element;
        // 既に処理済みの要素はスキップ
        if (el.hasAttribute('data-error-highlighted')) {
          return;
        }
        // 子ノードを処理
        Array.from(node.childNodes).forEach(walkAndHighlight);
      }
    };

    walkAndHighlight(logContainer);
  }

  function cleanLogText(text: string): string {
    // 行ごとに処理
    const lines = text.split('\n');
    const cleanedLines: string[] = [];

    // タイムスタンプの正規表現パターン
    const timestampPattern = /^(?:[A-Z][a-z]{2},\s+\d{1,2}\s+[A-Z][a-z]{2}\s+\d{4}\s+\d{2}:\d{2}:\d{2}\s+[A-Z]{3}\s*)+/;

    for (let line of lines) {
      const originalLine = line;

      // 行番号を削除（先頭の数字のみの行、または数字+空白+内容）
      line = line.replace(/^\s*\d+\s*$/, ''); // 数字のみの行
      line = line.replace(/^\s*\d+\s+/, '');   // 数字+空白+内容

      // タイムスタンプを削除（行の先頭から）
      line = line.replace(timestampPattern, '');

      // 余分な空白をトリム
      line = line.trim();

      // 行番号のみの行はスキップ
      if (originalLine.trim().match(/^\d+$/)) {
        continue;
      }

      // 行全体がタイムスタンプのみの場合はスキップ
      if (originalLine.trim().match(/^[A-Z][a-z]{2},\s+\d{1,2}\s+[A-Z][a-z]{2}\s+\d{4}\s+\d{2}:\d{2}:\d{2}\s+[A-Z]{3}$/)) {
        continue;
      }

      // ボタンのテキストを除外
      if (line === 'Copy' || line === 'Copying...' || line === '✓ Copied!' || line === '✗ Failed') {
        continue;
      }

      // ログをコピーというツールチップテキストを除外
      if (line === 'ログをコピー') {
        continue;
      }

      // 切り詰められた説明文を除外
      if (line.includes('This step has been truncated') ||
          line.includes('View the raw logs') ||
          line.includes('once the workflow run has completed')) {
        continue;
      }

      // "Error: Process completed with exit code"の行まで取得
      if (line.match(/^Error:\s*Process completed with exit code \d+\.?$/)) {
        cleanedLines.push(line);
        break;
      }

      // 空行でなければ追加
      if (line) {
        cleanedLines.push(line);
      }
    }

    return cleanedLines.join('\n');
  }

  async function getStepLogText(stepEl: Element): Promise<string> {
    // Shadow DOM内のログを探す
    if ('shadowRoot' in stepEl && stepEl.shadowRoot) {
      const logLines = stepEl.shadowRoot.querySelectorAll('[data-log-line], .js-job-log-line, .js-check-run-log-line');
      if (logLines.length > 0) {
        const text = Array.from(logLines)
          .map((line) => {
            // 行番号要素とタイムスタンプ要素を除外してテキストのみ取得
            const clone = line.cloneNode(true) as Element;
            const lineNumbers = clone.querySelectorAll('.line-number, [class*="line-number"], [class*="timestamp"], time, .time');
            lineNumbers.forEach(n => n.remove());
            return clone.textContent?.trim() || '';
          })
          .filter(Boolean)
          .join('\n');
        return cleanLogText(text);
      }
    }

    // 通常のDOMでログを探す - ボタンを除外
    const clone = stepEl.cloneNode(true) as Element;
    // ボタン要素とタイムスタンプ要素を削除
    const buttons = clone.querySelectorAll(`.${BUTTON_CLASS}`);
    buttons.forEach(btn => btn.remove());
    const timestamps = clone.querySelectorAll('[class*="timestamp"], time, .time');
    timestamps.forEach(ts => ts.remove());

    let logLines = clone.querySelectorAll('[data-log-line]');
    if (logLines.length > 0) {
      const text = Array.from(logLines)
        .map((line) => {
          // 行番号要素とタイムスタンプ要素を除外
          const lineClone = line.cloneNode(true) as Element;
          const toRemove = lineClone.querySelectorAll('.line-number, [class*="line-number"], [class*="LineNumber"], [class*="timestamp"], [class*="Timestamp"], time, .time');
          toRemove.forEach(n => n.remove());
          return lineClone.textContent?.trim() || '';
        })
        .filter(Boolean)
        .join('\n');
      return cleanLogText(text);
    }

    // テキストコンテンツを直接取得（ボタンを除外したクローンから）
    const htmlClone = clone as HTMLElement;
    let text = htmlClone.innerText || htmlClone.textContent || '';

    // ステップ名とタイミング情報を除外
    const stepName = stepEl.getAttribute('data-name');
    if (stepName) {
      // ステップ名の行を削除
      text = text.split('\n').filter(line => {
        const trimmed = line.trim();
        return trimmed !== stepName &&
               !trimmed.match(/^\d+[smh]$/) && // タイミング情報（例: "0s", "1m"）
               trimmed !== 'Copy' &&
               trimmed !== 'Copying...' &&
               trimmed !== '✓ Copied!' &&
               trimmed !== '✗ Failed' &&
               trimmed !== 'ログをコピー';
      }).join('\n');
    }

    if (!text.trim() || text.length < 10) {
      // ステップが展開されていない場合、展開を試みる
      const wasExpanded = stepEl.getAttribute('data-expand') === 'true';
      if (!wasExpanded) {
        // ステップをクリックして展開
        const htmlStepEl = stepEl as HTMLElement;
        htmlStepEl.click();
        await sleep(1000); // ログがロードされるまで待つ

        // 再度ログを取得（ボタンとタイムスタンプを除外）
        const expandedClone = stepEl.cloneNode(true) as Element;
        const expandedButtons = expandedClone.querySelectorAll(`.${BUTTON_CLASS}`);
        expandedButtons.forEach(btn => btn.remove());
        const expandedTimestamps = expandedClone.querySelectorAll('[class*="timestamp"], [class*="Timestamp"], time, .time');
        expandedTimestamps.forEach(ts => ts.remove());

        const expandedLogLines = expandedClone.querySelectorAll('[data-log-line]');
        if (expandedLogLines.length > 0) {
          const logText = Array.from(expandedLogLines)
            .map((line) => {
              const lineClone = line.cloneNode(true) as Element;
              const toRemove = lineClone.querySelectorAll('.line-number, [class*="line-number"], [class*="LineNumber"], [class*="timestamp"], [class*="Timestamp"], time, .time');
              toRemove.forEach(n => n.remove());
              return lineClone.textContent?.trim() || '';
            })
            .filter(Boolean)
            .join('\n');

          // 元の状態に戻す
          if (!wasExpanded) {
            htmlStepEl.click();
          }

          return cleanLogText(logText);
        }

        // 展開後のテキストを取得
        const expandedHtmlClone = expandedClone as HTMLElement;
        let expandedText = expandedHtmlClone.innerText || expandedHtmlClone.textContent || '';

        // ステップ名とタイミング情報を除外
        if (stepName) {
          expandedText = expandedText.split('\n').filter(line => {
            const trimmed = line.trim();
            return trimmed !== stepName &&
                   !trimmed.match(/^\d+[smh]$/) &&
                   trimmed !== 'Copy' &&
                   trimmed !== 'Copying...' &&
                   trimmed !== '✓ Copied!' &&
                   trimmed !== '✗ Failed' &&
                   trimmed !== 'ログをコピー';
          }).join('\n');
        }

        if (!wasExpanded) {
          htmlStepEl.click(); // 元に戻す
        }

        if (expandedText.trim()) {
          return cleanLogText(expandedText);
        }
      }
    }

    // 最終的にテキストがある場合はクリーンアップして返す
    if (text.trim()) {
      return cleanLogText(text);
    }

    return `ステップ "${stepName}" のログが見つかりませんでした。\nステップを展開してから再度お試しください。`;
  }

  async function copyToClipboard(text: string): Promise<void> {
    try {
      await navigator.clipboard.writeText(text);
      return;
    } catch (_) {
      const ta = document.createElement("textarea");
      ta.value = text;
      ta.style.position = "fixed";
      ta.style.left = "-9999px";
      document.body.appendChild(ta);
      ta.focus();
      ta.select();
      document.execCommand("copy");
      ta.remove();
    }
  }

  function ensureStyleOnce(): void {
    if (document.getElementById("km-gh-copy-style")) return;
    const style = document.createElement("style");
    style.id = "km-gh-copy-style";
    style.textContent = `
      check-step {
        position: relative;
      }
      .${BUTTON_CLASS} {
        position: absolute;
        right: 10px;
        top: 10px;
        z-index: 5;
        padding: 4px 8px;
        border: 1px solid var(--borderColor-default, #d0d7de);
        border-radius: 6px;
        background: var(--bgColor-default, #fff);
        color: var(--fgColor-default, #1f2328);
        cursor: pointer;
        font-size: 12px;
        line-height: 16px;
        font-weight: 500;
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
        transition: background 0.2s ease;
      }
      .${BUTTON_CLASS}:hover {
        background: var(--bgColor-muted, #f6f8fa);
      }
      .${BUTTON_CLASS}:disabled {
        opacity: 0.6;
        cursor: not-allowed;
      }
      .${BUTTON_CLASS}:active {
        transform: scale(0.95);
      }

      /* エラーメッセージのハイライト */
      .km-gh-error-highlight {
        color: #d73a49 !important;
        font-weight: 600 !important;
        background-color: rgba(215, 58, 73, 0.1) !important;
        padding: 2px 4px !important;
        border-radius: 3px !important;
      }

      /* ダークモード対応 */
      @media (prefers-color-scheme: dark) {
        .km-gh-error-highlight {
          color: #ff7b72 !important;
          background-color: rgba(255, 123, 114, 0.15) !important;
        }
      }
    `;
    document.head.appendChild(style);
  }

  function alreadyInjected(stepEl: Element): boolean {
    return !!stepEl.querySelector(`.${BUTTON_CLASS}`);
  }

  function findAllSteps(): NodeListOf<Element> {
    return document.querySelectorAll("check-step[data-name]");
  }

  function injectIntoStepRow(stepEl: Element): void {
    if (!stepEl || alreadyInjected(stepEl)) return;

    const btn = document.createElement("button");
    btn.type = "button";
    btn.className = BUTTON_CLASS;
    btn.textContent = "Copy";
    btn.title = "ログをコピー";

    btn.addEventListener("click", async (e: Event) => {
      e.stopPropagation();
      e.preventDefault();

      btn.disabled = true;
      const orig = btn.textContent;
      btn.textContent = "Copying...";

      try {
        const text = await getStepLogText(stepEl);
        console.log('Raw log text:', text); // デバッグ用
        if (!text) throw new Error("log text is empty");
        await copyToClipboard(text);
        btn.textContent = "✓ Copied!";
        await sleep(1500);
      } catch (e) {
        console.error('Copy failed:', e);
        btn.textContent = "✗ Failed";
        await sleep(1500);
      } finally {
        btn.textContent = orig;
        btn.disabled = false;
      }
    });

    stepEl.appendChild(btn);
  }

  function tick(): void {
    ensureStyleOnce();
    const steps = findAllSteps();
    steps.forEach((stepEl) => {
      injectIntoStepRow(stepEl);
      highlightErrorsInStep(stepEl);
    });
  }

  // SPA & 遅延描画対策
  const observer = new MutationObserver(() => tick());
  observer.observe(document.documentElement, { childList: true, subtree: true });

  // 初回実行
  tick();

  // ページロード後にも再実行
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', tick);
  } else {
    setTimeout(tick, 500);
  }
})();
