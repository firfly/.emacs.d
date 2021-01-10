
(require 'org-install)
(require 'ob-tangle)
(require 'org-tempo)
   (setq byte-compile-warnings '(cl-functions))

;; (org-babel-load-file (expand-file-name "firfly.org" user-emacs-directory))
(add-to-list 'load-path "~/.emacs.d/lisp/")


(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(require 'init-packages)
(require 'init-ui)
(require 'init-better-defaults)
(require 'init-org)
(require 'init-keybindings)

(setq custom-file (expand-file-name "lisp/custom.el" user-emacs-directory))
