;;; init.el --- Complete modern Emacs config

;; ===========================================
;; ロケール / 日本語設定
;; ===========================================
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(setenv "LANG" "ja_JP.UTF-8")

;; ===========================================
;; UI 基本設定
;; ===========================================
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode t)
(column-number-mode t)
(show-paren-mode t)
(global-hl-line-mode 1)

(setq-default indent-tabs-mode nil)
(setq auto-save-default nil)
(setq make-backup-files nil)

(setq evil-want-fine-undo t)
(setq evil-kill-on-visual-paste nil)

;; ===========================================
;; パッケージ管理
;; ===========================================
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))
(unless package--initialized
  (package-initialize))
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)


;; ===========================================
;; which-key（キーバインド候補表示）
;; ===========================================
(use-package which-key
  :config
  (which-key-mode 1)
  (setq which-key-idle-delay 0.3))

;; ===========================================
;; テーマ
;; ===========================================
(use-package dracula-theme
  :config
  (load-theme 'dracula t))


;; ===========================================
;; Ivy / Counsel / Swiper（補完 & 検索）
;; ===========================================
;;; ---------------------------------------------------------
;;; 2. UIと検索ロジック (Vertico + Orderless)
;;; ---------------------------------------------------------
(use-package vertico
  :init
  (vertico-mode)
  :config
  ;; 補完サイクルを有効にする
  (setq vertico-cycle t))

;; 検索スタイルを「スペース区切り」で曖昧検索できるようにする
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; 補完候補にリッチな情報（ファイルサイズや説明）を表示
(use-package marginalia
  :init
  (marginalia-mode))

;;; ---------------------------------------------------------
;;; 3. 画面中央にフロート表示 (Telescope風の見た目)
;;; ---------------------------------------------------------
(use-package vertico-posframe
  :after vertico
  :config
  (vertico-posframe-mode 1)
  ;; 画面中央に表示
  (setq vertico-posframe-poshandler #'posframe-poshandler-frame-center)
  ;; ウィンドウの見た目調整
  (setq vertico-posframe-parameters
        '((left-fringe . 8)
          (right-fringe . 8))))

;;; ---------------------------------------------------------
;;; 4. 強力な検索コマンド集 (Consult) - 「起動時の場所」固定版
;;; ---------------------------------------------------------

;; 1. Emacs起動時のディレクトリをグローバル変数として保存しておく
(defvar my-start-directory default-directory
  "Emacsを起動した時のディレクトリを保持する変数")

(use-package consult
  :bind
  ;; 2. コマンド実行時に、保存しておいた `my-start-directory` を引数として渡す
  (("C-c f" . (lambda ()
                (interactive)
                (consult-find my-start-directory)))     ; 常に起動時の場所からファイル検索

   ("C-c r" . (lambda ()
                (interactive)
                (consult-ripgrep my-start-directory)))  ; 常に起動時の場所からgrep

   ("C-x b" . consult-buffer)        ; バッファ切り替え
   ("C-c l" . consult-line)          ; バッファ内検索
   ("C-y"   . consult-yank-pop))     ; クリップボード履歴
  :config
  (setq consult-preview-key 'any))

;; ===========================================
;; Company（自動補完）
;; ===========================================
(use-package company
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 1
        company-selection-wrap-around t))


;; ===========================================
;; Flycheck（構文チェック）
;; ===========================================
(use-package flycheck
  :hook (after-init . global-flycheck-mode))


;; ===========================================
;; Projectile（プロジェクト管理）
;; ===========================================
(use-package projectile
  :config
  (projectile-mode +1)
  (setq projectile-completion-system 'ivy)
  :bind-keymap
  ("C-c p" . projectile-command-map))


;; ===========================================
;; Magit（最強のGitクライアント）
;; ===========================================
(use-package magit
  :commands magit-status
  :bind (("C-x g" . magit-status)))


;; ===========================================
;; Ace-Window（ウィンドウ移動）
;; ===========================================
(use-package ace-window
  :bind (("M-o" . ace-window)))


;; ===========================================
;; LSP（IDE機能）
;; ===========================================
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook ((go-mode        . lsp-deferred)
         (python-mode    . lsp-deferred)
         (typescript-mode . lsp-deferred)
         (rust-mode      . lsp-deferred)
         (js-mode        . lsp-deferred))
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (setq lsp-prefer-capf t
        lsp-enable-snippet t))

(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-delay 0.3
        lsp-ui-sideline-enable t))


;; ===========================================
;; ★ 8割のEmacserが使う超定番パッケージ群 ★
;; ===========================================

;; Evil（Vimキーバインド）
;; (use-package evil
;;   :init
;;   (setq evil-want-C-u-scroll t
;;         evil-want-keybinding nil)
;;   :config
;;   (evil-mode 1))

;; (use-package evil-collection
;;   :after evil
;;   :config
;;   (evil-collection-init))


;; Avy（高速ジャンプ）
(use-package avy
  :bind (("C-:" . avy-goto-char)
         ("C-'" . avy-goto-word-1)
         ("M-g f" . avy-goto-line)))


;; Undo-tree（Undoの木構造）
(use-package undo-tree
  :init (global-undo-tree-mode))


;; savehist / saveplace / recentf（履歴・場所・最近ファイル）
(savehist-mode 1)
(save-place-mode 1)

(recentf-mode 1)
(setq recentf-max-saved-items 300)


;; Expand-region（賢い選択拡大）
(use-package expand-region
  :bind (("C-=" . er/expand-region)))


;; Smartparens（括弧補完）
(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode 1))


;; Multiple-cursors（VSCode風マルチカーソル）
(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)))


;; Org-mode 強化
(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

(use-package org-modern
  :hook (org-mode . org-modern-mode))


;; ===========================================
;; メジャーモード（言語サポート）
;; ===========================================

(use-package go-mode :mode "\\.go\\'")
(use-package python-mode :mode "\\.py\\'")
(use-package typescript-mode :mode "\\.ts\\'")
(use-package js2-mode :mode "\\.js\\'")
(use-package rust-mode :mode "\\.rs\\'")
(use-package yaml-mode :mode "\\.ya?ml\\'")
(use-package toml-mode :mode "\\.toml\\'")


;;; init.el ends here
(defun my/fd-find-file (pattern)
  "Search files using fd from current directory (Neovim style)."
  (interactive "sSearch: ")
  (let* ((root default-directory)  ;; ← Projectileは使わず、Emacsのcwdを root に
         (default-directory root)
         (cmd (format "fd -t f \"%s\"" pattern))
         (results (split-string (shell-command-to-string cmd) "\n" t)))
    (if (null results)
        (message "No files found.")
      (let ((file (completing-read "Open: " results)))
        (find-file file)))))

(global-set-key (kbd "C-x f") 'my/fd-find-file)

(defun my/rg-search (pattern)
  "Search text using ripgrep (rg) from current directory (Neovim style)."
  (interactive "sRG Search: ")
  (let* ((root default-directory) ;; ← Neovim 的。cwd が root になる
         (default-directory root)
         (cmd (format "rg --line-number --no-heading --color never \"%s\"" pattern))
         (raw (shell-command-to-string cmd))
         (results (split-string raw "\n" t)))
    (if (null results)
        (message "No matches found.")
      (let* ((choice (completing-read "Select match: " results))
             (parts (split-string choice ":"))
             (file (nth 0 parts))
             (line (string-to-number (nth 1 parts))))
        (find-file file)
        (goto-line line)))))

(global-set-key (kbd "C-x r") 'my/rg-search)


(provide 'init)
