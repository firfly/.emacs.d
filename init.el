(setq byte-compile-warnings '(cl-functions))

(add-to-list 'load-path "~/.emacs.d/lisp/")


(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(require 'init-packages)
(require 'init-ui)
(require 'init-better-defaults)
(require 'init-keybindings)
(require 'org)


;;set windows numbering
(window-numbering-mode 1)



(setq custom-file (expand-file-name "lisp/custom.el" user-emacs-directory))
(load-file custom-file)
