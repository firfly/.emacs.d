(setq ring-bell-function 'ignore)

(set-language-environment "UTF-8")

(global-auto-revert-mode t)

(global-linum-mode t)

(abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
					    ;; signature
					    ("5f" "firfly")
					    ;; Microsoft
					    ("8ms" "Microsoft")
					    ))


(setq make-backup-files nil)
(setq auto-save-default nil)

(recentf-mode 1)			
(setq recentf-max-menu-items 25)

;; (define-advice show-paren-function (:around (fn) fix-show-paren-function)
;;   "Highlight enclosing parens."
;;   (cond ((looking-at-p "\\s(") (funcall fn))
;;         (t (save-excursion
;;              (ignore-errors (backward-up-list))
;;              (funcall fn)))))

(defadvice show-paren-function (around fix-show-paren-function activate)
  (cond ((looking-at-p "\\s(") ad-do-it)
	(t (save-excursion
	     (ignore-errors (backward-up-list))
	     ad-do-it)))
  )


(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)


(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

(delete-selection-mode t)


(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  ;;reveal-in-osx-finder   It is bound to RET, a.
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer ()
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indented selected region."))
      (progn
        (indent-buffer)
        (message "Indented buffer.")))))


;; hippie expand is dabbrev expand on steroids
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))

(fset 'yes-or-no-p 'y-or-n-p)

(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)

(put 'dired-find-alternate-file 'disabled nil)

;; C-x C-j  打开当前文件的目录
(require 'dired-x)

(setq dired-dwim-target t)

;; dwin = do what i mean.
(defun occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
            (buffer-substring-no-properties
             (region-beginning)
             (region-end))
          (let ((sym (thing-at-point 'syombol)))
            (when (stringp sym)
              (regexp-qouote sym))))
        regexp-history)
  (call-interactively 'occur))


(defun firfly/insert-chrome-current-tab-url()
  "Get the URL of the active tab of the first window"
  (interactive)
  (insert (firfly/retrieve-chrome-current-tab-url)))


(defun firfly/retrieve-chrome-current-tab-url()
  "Get the URL of the active tab of the first window"
  (interactive)
  (let ((result (do-applescript
                 (concat
                  "set frontmostApplication to path to frontmost application\n"
                  "tell application \"$1\"\n"
                  "	set theUrl to get URL of active tab of first window\n"
                  "	set theResult to (get theUrl) \n"
                  "end tell\n"
                  "activate application (frontmostApplication as text)\n"
                  "set links to {}\n"
                  "copy theResult to the end of links\n"
                  "return links as string\n"))))
    (format "%s" (s-chop-suffix "\"" (s-chop-prefix "\"" result)))))

(display-time-mode 1) ;; 常显
(setq display-time-24hr-format t) ;;格式
(setq display-time-day-and-date t) ;;显示时间、星期、日期

;; 行号背景
(set-face-background 'linum "#000000")

;; 行号前景
(set-face-foreground 'linum "#CD661D")

;; 当前行背景
(set-face-background 'hl-line "#545454")


;; 当前行前景
;; (set-face-foreground 'hl-line "#000000")

(provide 'init-better-defaults)
