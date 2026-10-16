# AIルールのセットアップ

## 配布元の構成

```text
ai-rule/
├── USER_RULE.md             # 共通ルールの唯一のソース
├── skills/
│   ├── report/SKILL.md
│   └── review-pr/SKILL.md
├── setup.sh
└── SETUP.md
```

共通ルールの本文は`USER_RULE.md`だけで管理します。セットアップ時にClaude Codeの`CLAUDE.md`とCodexの`AGENTS.md`へ同じ内容をコピーします。Cursor向けには`.mdc`のfrontmatterを付けて生成します。ツール別のルール本文ファイルはリポジトリに置きません。スキルはスキルごとのディレクトリに`SKILL.md`を置く形式です。

## インストール先

セットアップスクリプトは現在のユーザーのホームディレクトリに以下を配置します。

```text
~/.claude/CLAUDE.md
~/.claude/skills/<skill-name>/SKILL.md
~/AGENTS.md
~/.agents/skills/<skill-name>/SKILL.md
~/.cursor/rules/ai-rule.mdc
~/.agents/skills/<skill-name>/SKILL.md
```

CursorとCodexで共有スキルを`~/.agents/skills`に配置します。既存の同名ファイルと内容が異なる場合、元ファイルを`.backup.<日時>`として保存してから更新します。同じ内容ならそのままです。

## 実行

リポジトリのルートから実行します。

```bash
./ai-rule/setup.sh
```

または、どのディレクトリからでもスクリプトのパスを指定できます。インストール対象のホームは`HOME`環境変数で決まります。

```bash
bash /path/to/dotfiles/ai-rule/setup.sh
```

## テスト

一時ホームディレクトリにセットアップし、各ツール向けルールと全スキルの配置、再実行時に余計なバックアップを作らないこと、既存ファイルのバックアップと更新を確認します。

```bash
bash -n ai-rule/setup.sh ai-rule/test_setup.sh
bash ai-rule/test_setup.sh
```

`.github/workflows/test-ai-rule.yml`が`ai-rule/**`の変更時に同じチェックを実行します。
