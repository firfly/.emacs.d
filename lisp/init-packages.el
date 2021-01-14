(require 'cl)

(when (>= emacs-major-version 24)
  ;;  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                           ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
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
			  reveal-in-osx-finder
			  web-mode
			  js2-refactor
			  expand-region
			  iedit
			  org-pomodoro
			  ;; first of install ag in osx,  brew install the_silver_searcher
			  helm-ag
			  ;; npm install -g eslint ; eslint --version
			  flycheck
			  auto-yasnippet
			  powerline-evil
			  evil
			  evil-leader
			  evil-surround
			  evil-nerd-commenter
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
(with-eval-after-load 'smartparens
  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil))



;; config for ivy (swiper) 
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)


;; config js2-mode for js files
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       '(("\\.html\\'" . web-mode))
       auto-mode-alist))

(require 'nodejs-repl)

(global-company-mode t)


;; config for web mode

(defun my-web-mode-indent-setup ()
  (setq web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 2)    ; web-mode, css in html file
  (setq web-mode-code-indent-offset 2)   ; web-mode, js code in html file
  )

(add-hook 'web-mode-hook 'my-web-mode-indent-setup)

(defun my-toggle-web-indent ()
  (interactive)
  ;; web development
  (if (or (eq major-mode 'js-mode) (eq major-mode 'js2-mode))
      (progn
        (setq js-indent-level (if (= js-indent-level 2) 4 2))
        (setq js2-basic-offset (if (= js2-basic-offset 2) 4 2))))

  (if (eq major-mode 'web-mode)
      (progn (setq web-mode-markup-indent-offset (if (= web-mode-markup-indent-offset 2) 4 2))
             (setq web-mode-css-indent-offset (if (= web-mode-css-indent-offset 2) 4 2))
             (setq web-mode-code-indent-offset (if (= web-mode-code-indent-offset 2) 4 2))))
  (if (eq major-mode 'css-mode)
      (setq css-indent-offset (if (= css-indent-offset 2) 4 2)))

  (setq indent-tabs-mode nil))

;; config for js2-refactor
(add-hook 'js2-mode-hook #'js2-refactor-mode)


(defun js2-imenu-make-index ()
  (interactive)
  (save-excursion
    ;; (setq imenu-generic-expression '((nil "describe\\(\"\\(.+\\)\"" 1)))
    (imenu--generic-function '(("describe" "\\s-*describe\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                               ("it" "\\s-*it\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                               ("test" "\\s-*test\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                               ("before" "\\s-*before\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                               ("after" "\\s-*after\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                               ("Function" "function[ \t]+\\([a-zA-Z0-9_$.]+\\)[ \t]*(" 1)
                               ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
                               ("Function" "^var[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
                               ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*()[ \t]*{" 1)
                               ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*:[ \t]*function[ \t]*(" 1)
                               ("Task" "[. \t]task([ \t]*['\"]\\([^'\"]+\\)" 1)))))
(add-hook 'js2-mode-hook
          (lambda ()
            (setq imenu-create-index-function 'js2-imenu-make-index)))

(load-theme 'monokai-pro t)

(require 'popwin)
(popwin-mode t)

;;set windows numbering
(window-numbering-mode 1)

(require 'org-pomodoro)

(add-hook 'js2-mode-hook 'flycheck-mode)

(require 'yasnippet)
(yas-reload-all)
(add-hook 'prog-node-hook #'yas-minor-mode)

(evil-mode t)

(global-evil-leader-mode)

(evil-leader/set-key
  "ff" 'find-file
  "fr" 'recentf-open-files
  "pf" 'counsel-git
  "ps" 'helm-do-ag-project-root
  "sb" 'switch-to-buffer
  "kb" 'kill-buffer
  "0" 'select-window-0
  "1" 'select-window-1
  "2" 'select-window-2
  "3" 'select-window-3
  "w/" 'split-window-right
  "w-" 'split-window-below
  "wo" 'delete-other-windows
  ":" 'counsel-M-x)

(require 'powerline)
(powerline-default-theme)

(require 'evil-surround)
(global-evil-surround-mode 1)

(define-key evil-normal-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
(define-key evil-visual-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
(evilnc-default-hotkeys)


(provide 'init-packages)
