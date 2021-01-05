(require 'cl)

  (when (>= emacs-major-version 24)
      (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
    )

  ;;add whatever packages you want here
  (defvar firfly/packages '(
                            company
			    monokai-pro-theme
                            hungry-delete
			    swiper
			    counsel
			    smartparens
			    js2-mode
			    nodejs-repl
			    exec-path-from-shell
			    popwin
          window-numbering
			    )  "Default packages")

(setq package-selected-packages firfly/packages)

      
  (defun firfly/packages-installed-p ()
    (loop for pkg in firfly/packages
          when (not (package-installed-p pkg)) do (return nil)
          finally (return t)))

  (unless (firfly/packages-installed-p)
    (message "%s" "Refreshing package database...")
    (package-refresh-contents)
    (dolist (pkg firfly/packages)
      (when (not (package-installed-p pkg))
        (package-install pkg))))

;; let emacs could find the executable file
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;;(require 'hungry-delete)
(global-hungry-delete-mode)

;;(require 'smartparens-config)
;(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(smartparens-global-mode t)

;; config for ivy (swiper) 
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)


;; config js2-mode for js files
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))

(require 'nodejs-repl)

(global-company-mode t)
(load-theme 'monokai-pro t)

(require 'popwin)
(popwin-mode t)


;;set windows numbering
(window-numbering-mode 1)


(provide 'init-packages)
