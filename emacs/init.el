;; mkdir -p ~/.emacs.d
;; cp ~/dotfiles/emacs/init.el ~/.emacs.d


;; ~/dotfiles/emacs/setting.el を読み込む
(let ((setting-file (expand-file-name "~/dotfiles/emacs/setting.el")))
  (when (file-exists-p setting-file)
    (load setting-file)))
