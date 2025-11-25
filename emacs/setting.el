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


;; ===========================================
;; Telescope 的 UI: Vertico + Orderless + Consult
;; ===========================================
(use-package vertico
  :init
  (vertico-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles orderless)))))

(use-package consult
  :bind (("C-s"     . consult-line)
         ("C-p"     . consult-buffer)
         ("C-f"     . consult-find)
         ("C-c g"   . consult-ripgrep)
         ("M-g M-g" . consult-goto-line)
         ("M-i"     . consult-imenu)))

(use-package marginalia
  :init
  (marginalia-mode))

