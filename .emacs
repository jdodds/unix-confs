(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(show-paren-mode t)
(iswitchb-mode t)    ;fuck yes
(winner-mode 1)
(display-battery-mode 1)

(global-auto-revert-mode)

(add-to-list 'load-path "~/.emacs.d/")
(require 'auto-complete)
(global-auto-complete-mode t)

(require 'yasnippet-bundle)

(require 'psvn)

(defun untabify-and-indent ()
  (interactive)
  (untabify (point-min) (point-max))
  (indent-region (point-min) (point-max)))
    

;(load-library "init_python")
(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(load "~/.emacs.d/nxhtml/autostart.el")

;automatically guess style based on the file we're opening
;(autoload 'guess-style-set-variable "guess-style" nil t)
;(autoload 'guess-style-guess-variable "guess-style")
;(autoload 'guess-style-guess-all "guess-style" nil t)

;indent styles for c modes (php atm)
(defun my-c-mode-hoook ()
  (c-set-style "awk")
  (setq tab-width 2
        indent-tabs-mode nil)
  (c-toggle-hungry-state 1)
  (c-toggle-auto-state 1)
  (c-set-offset 'arglist-close 0)
  (setq c-basic-offset 2))

(add-hook 'c-mode-common-hook 'my-c-mode-hoook)
;(add-hook 'c-mode-common-hook 'guess-style-guess-all)

;keep TRAMP from saving backups
(add-to-list 'backup-directory-alist
             (cons tramp-file-name-regexp nil))

(setq tramp-default-method "ssh")

;(add-to-list 'tramp-default-proxies-alist
;             '("dev1" "\\`root\\'" "/ssh:%h:"))

;save auto backups in the systems temp directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-tranforms
      `((".*" ,temporary-file-directory t)))

;templates
(require 'autoinsert)
(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/templates/")
(setq auto-insert-query nil) ; don't ask to insert templates
(define-auto-insert "\.sh" "bash-template.sh")
(define-auto-insert "\.php" "php-template.php")
(define-auto-insert "\.py" "python-template.py")

;python
(add-hook 'python-mode-hook '(lambda ()
                               (require 'virtualenv)
                               (setq virtualenv-root-dir
                                     (concat (getenv "HOME") "/workspace/"))))

;yaml
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))


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
(setq-default tab-width 2)

(auto-fill-mode 1)

(require 'tramp)

;rst
(load "~/.emacs.d/rst.el")
(require 'rst)
(add-to-list 'auto-mode-alist '("\\.rst$" . rst-mode))

;haskell
(load "~/.emacs.d/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;(add-hook 'haskell-mode-hook 'guess-style-guess-all)

;ERC
(setq erc-auto-query 'buffer)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key "\C-cy" 'clipboard-yank)
(global-set-key "\C-ck" 'clipboard-kill-ring-save)
(global-set-key "\C-cc" 'comment-or-uncomment-region)

;ORG
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-log-done 'time)

(global-font-lock-mode 1)

;lua
(setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist
   (cons '("\\.md" . markdown-mode) auto-mode-alist))


;always reindent after yanking for most major modes
(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
           (and (not current-prefix-arg)
                (not (member major-mode '(text-mode fundamental-mode)))
                (let ((mark-even-if-inactive transient-mark-mode))
                  (indent-region (region-beginning) (region-end) nil))))))


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

;utility keybindings
(global-set-key "\C-x\C-b" 'browse-url-at-point)


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
(let ((height 
       (cond ((string-match "destructor" system-name) 70)
             (t 110))))
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   `(default ((t (:stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height ,height :width normal :foundry "Adobe" :family "Courier"))))
   '(mmm-default-submode-face ((t (:background "gray85" :foreground "black"))))
   '(mumamo-background-chunk-major ((((class color) (min-colors 88) (background dark)) (:background "black"))))
   '(mumamo-background-chunk-submode1 ((((class color) (min-colors 88) (background dark)) (:background "black"))))))

