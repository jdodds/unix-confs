(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(show-paren-mode t)
(iswitchb-mode t)    ;fuck yes
(winner-mode 1)
(display-battery-mode 1)

(add-to-list 'load-path "~/.emacs.d/")
(require 'auto-complete)
(global-auto-complete-mode t)

(require 'yasnippet-bundle)

(require 'psvn)

;(load-library "init_python")
(load-library "espresso")
(load "~/.emacs.d/nxhtml/autostart.el")


;indent styles for c modes (php atm)
(defun my-c-mode-hoook ()
  (c-set-style "awk")
  (setq tab-width 2
        indent-tabs-mode nil)
  (c-toggle-hungry-state 1)
  (c-toggle-auto-state 1)
  (setq c-basic-offset 2))

(add-hook 'c-mode-common-hook 'my-c-mode-hoook)
                                 
                                           
                                           

;php
;; (load "php-mode")
;; (add-to-list 'auto-mode-alist
;;              '("\\.php[345]?\\'\\|\\.phtml\\'" . php-mode))

;worklog
;(load "~/workspace/worklog/worklog.el")
;(require 'worklog)
;(setq worklog-automatic-login t)


;keep TRAMP from saving backups
(add-to-list 'backup-directory-alist
             (cons tramp-file-name-regexp nil))

(setq tramp-default-method "ssh")

(autoload 'word-count-mode "word-count"
  "Minor mode to count words" t nil)

(setq transient-mark-mode nil)
(setq auto-save-default nil)
(setq column-number-mode t)
(setq enable-recursive-minibuffers t)
(setq display-buffer-reuse-frames t)
(setq midnight-mode t)    ;cleans up every night.

(setq truncate-partial-width-windows nil)

(setq-default fill-column 80)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(auto-fill-mode 1)

(require 'tramp)

;javascript
;(autoload 'js2-mode "js2" nil t)
;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;mmm
;  (require 'mmm-mode)
;  (load "~/.emacs.d/mmm-mako.el")
;  (setq mmm-global-mode 'maybe)
;  (add-to-list 'auto-mode-alist '("\\.mako$'" . html-mode))
;  (mmm-add-mode-ext-class 'html-mode "\\.mako$'" 'mako)

  ;for mmm-confusion . . .
;  (global-set-key "\M-p" 'mmm-parse-buffer)

;rst
(load "~/.emacs.d/rst.el")
(require 'rst)
(add-to-list 'auto-mode-alist '("\\.rst$" . rst-mode))

;for python 
;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             (define-key python-mode-map (kbd "C-c % c") 'python-insert-class)
;;             (define-key python-mode-map (kbd "C-c % d") 'python-insert-def)
;;             ))

;haskell
(load "~/.emacs.d/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)




;skeletons
(define-skeleton html-base
  "A base skeleton for html files"
  "<html>\n"
  "<head>\n"
  "<title>" (skeleton-read "title: ") "</title>\n"
  "</head>\n"
  "<body>\n"
   _ "\n"
  "</body>\n"
  "</html>\n"
)

(defun html-file
  (interactive 't)
  (html-base)
  (point-min-marker)
  (point-max-marker)
  (indent-region))



;ERC
(setq erc-auto-query 'buffer)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key "\C-cy" 'clipboard-yank)
(global-set-key "\C-ck" 'clipboard-kill-ring-save)
(global-set-key "\C-cc" 'comment-region)

;;mainly for python programs
(defun insert-coding (coding)
  (interactive "sCoding:")
  (save-excursion
    (goto-char (point-min))
    (insert "# -*- coding: " coding " -*- #\n")))

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)

(global-font-lock-mode 1)

;lua
(setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)


;BELOW HERE THERE BE DRAGONS.

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(c-label-minimum-indentation 2)
 '(c-syntactic-indentation t)
 '(python-honour-comment-indentation nil)
 '(python-use-skeletons nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal :foundry "apple" :family "Courier"))))
 '(mmm-default-submode-face ((t (:background "gray85" :foreground "black"))))
 '(mumamo-background-chunk-major ((((class color) (min-colors 88) (background dark)) (:background "black"))))
 '(mumamo-background-chunk-submode1 ((((class color) (min-colors 88) (background dark)) (:background "black")))))

(put 'narrow-to-region 'disabled nil)


(defun jump-to-window (buffer-name)
  (interactive "bEnter buffer to jump to: ")
  (let ((visible-buffers (mapcar '(lambda (window) (buffer-name (window-buffer window))) (window-list)))
	window-of-buffer)
    (if (not (member buffer-name visible-buffers))
	(error "'%s' does not have visible window" buffer-name)
      (setq window-of-buffer
	    (delq nil (mapcar '(lambda (window) 
				  (if (equal buffer-name (buffer-name (window-buffer window)))
				      window nil)) (window-list))))
      (select-window (car window-of-buffer)))))
(global-set-key "\C-xB" 'jump-to-window)

(defun macro-query (arg)
  (interactive "P")
  (let* ((prompt (if arg (read-from-minibuffer "PROMPT: ") "Input: "))
         (input (minibuffer-with-setup-hook (lambda () (kbd-macro-query t))
                  (read-from-minibuffer prompt))))
    (unless (string= "" input) (insert input))))

(global-set-key "\C-xQ" 'macro-query)