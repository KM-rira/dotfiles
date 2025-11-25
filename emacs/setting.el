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

(use-package projectile
  :init
  (projectile-mode +1)
  :config
  ;; プロジェクト認識の仕組み
  (setq projectile-project-search-path '("~/"))
  (setq projectile-enable-caching t))

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

(global-set-key (kbd "C-x g") 'my/rg-search)


