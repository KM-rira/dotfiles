;; sudo apt install fonts-ipafont
;; sudo update-locale LANG=ja_JP.UTF-8
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(set-fontset-font t 'japanese-jisx0208 (font-spec :family "Hiragino Maru Gothic ProN"))

;; ===========================================
;; Package setup（use-package 有効化）
;; ===========================================
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu"   . "https://elpa.gnu.org/packages/")))
;; ※ (package-initialize) は不要（Emacs27+）

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)


;; ===========================================
;; Basic comfort settings
;; ===========================================
(setq inhibit-startup-message t)
(global-display-line-numbers-mode t)
(column-number-mode t)
(show-paren-mode t)
(setq-default indent-tabs-mode nil)
(setq auto-save-default nil)
(setq make-backup-files nil)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)


;; ===========================================
;; ivy
;; ===========================================
(use-package ivy
  :init
  (ivy-mode 1))

;; which-key
(use-package which-key
  :init (which-key-mode))


;; ===========================================
;; Theme
;; ===========================================
(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-medium t))


;; ===========================================
;; LSP (Go)
;; ===========================================
(use-package go-mode)

(use-package lsp-mode
  :hook (go-mode . lsp-deferred)
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-prefer-flymake nil))

(use-package lsp-ui
  :commands lsp-ui-mode)


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
;;; 4. 強力な検索コマンド集 (Consult)
;;; ---------------------------------------------------------
;; consult-fd を使う（fd がインストールされている必要あり）
(use-package consult
  :bind
  (("C-c f" . consult-fd)          ; ← 修正ポイント（最重要）
   ("C-c r" . consult-ripgrep)
   ("C-x b" . consult-buffer)
   ("C-c l" . consult-line)
   ("C-y"   . consult-yank-pop))
  :config
  (setq consult-preview-key 'any))
