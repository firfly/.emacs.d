
  (when (>= emacs-major-version 24)
    (require 'package)
    (package-initialize)
    (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
    )
  (require 'cl)

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

(require 'hungry-delete)
(global-hungry-delete-mode)

(require 'smartparens-config)
;(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(smartparens-global-mode t)

;; config js2-mode for js files
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))

(require 'nodejs-repl)



;; config for ivy (swiper) 
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)

        
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-splash-screen t)
(global-linum-mode t)

(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "<f2>") 'open-my-init-file)

(global-company-mode t)
(setq-default cursor-type 'bar)

(setq make-backup-files nil)
(setq auto-save-default nil)

  (require 'org)
  (setq org-src-fontify-natively t)

(require 'recentf)
(recentf-mode 1)			
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(delete-selection-mode t)
(setq  initial-frame-alist (quote ((fullscreen . maximized))))

(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
(global-hl-line-mode t)
(load-theme 'monokai-pro t)

(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

(setq org-agenda-files '("~/org"))
(global-set-key (kbd "C-c a") 'org-agenda)


;; load theme monokai-pro-theme 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-idle-delay 0.08)
 '(company-minimum-prefix-length 1)
 '(custom-safe-themes
   '("5846b39f2171d620c45ee31409350c1ccaddebd3f88ac19894ae15db9ef23035" default))
 '(package-selected-packages '(company monokai-pro-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
