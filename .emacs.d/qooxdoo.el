;;; qooxdoo.el --- helper functions for working with qooxdoo

;; Copyright (C) 2010  Jeremiah Dodds

;; Author: Jeremiah Dodds <jeremiah.dodds@gmail.com>
;; Keywords: convenience, docs

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; The cleanest way I've found to load this so for is using eproject in
;; combination with espect. see <https://github.com/jrockway/eproject> and
;; <https://github.com/rafl/espect>. Something like:

;; (require 'eproject)
;; (define-project-type qooxdoo (generic)
;;   (and (look-for "generator.py")
;;        (look-for "Manifest.json")
;;        (look-for "config.json"))
;;   :relevant-files ("\\.js$"))
;;
;; (require 'espect)
;; (setq espect-buffer-settings
;;       '(((:project "qooxdoo")
;;          (lambda ()
;;            (require 'qooxdoo)
;;            (qooxdoo-minor-mode t)))))

;; in your .emacs should do just fine.
;;; Code:

;;;###autoload
(defgroup qooxdoo nil
  "Convenience functions for working with qooxdoo apps"
  :prefix "qooxdoo-"
  :group 'convenience)

(defcustom qooxdoo-mode-string-format " [%s]"
  "Format for the mode string. It should start with a space."
  :group 'qooxdoo
  :type 'string)

(defcustom qooxdoo-mode-name (format qooxdoo-mode-string-format "qx")
  "The string to display as the name of qooxdoo-minor-mode")

(defcustom qooxdoo-api-url "http://demo.qooxdoo.org/current/apiviewer/#"
  "URL where the qooxdoo api lives"
  :type 'string
  :group 'qooxdoo)

(defcustom qooxdoo-js-mode 'espresso-mode
  "The major mode used for javascript"
  :type 'symbol
  :group 'qooxdoo)

(defcustom qooxdoo-workspace-path nil
  "If you store your code under a shared root, you can put it here"
  :type 'string
  :group 'qooxdoo)

(defcustom qooxdoo-project-paths nil
  "A list of paths containing qooxdoo projects.
These are prefixed with `qooxdoo-workspace-path'"
  :type 'list
  :group 'qooxdoo)

;; set us up to load automatically, requres espect
(require 'espect)

(defun qooxdoo-normalize-project-path (filename)
  (let ((fname (file-name-as-directory filename)))
    (if qooxdoo-workspace-path
        (concat
         (file-name-as-directory qooxdoo-workspace-path)
         fname)
      fname)))

(defun qooxdoo-make-search-targets ()
  (mapcar
   '(lambda (i)
      (cons i (file-name-as-directory buffer-file-name)))
   (mapcar
    'qooxdoo-normalize-project-path
    qooxdoo-project-paths)))

(define-espect-rule :qooxdoo ()
  (if buffer-file-name  ;; this gets called in the minibuffer for completion as well
      (and
       (or
        (mapcar
         '(lambda (i)
            (string-match (car i) (cdr i)))
         (qooxdoo-make-search-targets)))
       (string-match "\\.js$" buffer-file-name))))

;; thingatpt and api search utils
(require 'thingatpt)
(defun qooxdoo-bounds-of-qooxdoo-at-point ()
  "Return the (possibly chained) class heirarchy at point"
  (save-excursion
    (skip-chars-backward "$0-9a-zA-z\._")
    (if (looking-at "[$0-9a-zA-z._]+")
        (cons (point)
              (match-end 0))
      nil)))

(put 'qooxdoo 'bounds-of-thing-at-point
     'qooxdoo-bounds-of-qooxdoo-at-point)

(defun qooxdoo-search-api ()
  "Bring up the qooxdoo docs for the function at point"
  (interactive)
  (browse-url (concat qooxdoo-api-url (thing-at-point 'qooxdoo))))

(defvar qooxdoo-mode-keymap (make-keymap)
  "keymap for qooxdoo-mode")
(define-key qooxdoo-mode-keymap (kbd "C-c f") 'qooxdoo-search-api)

;;;###autoload
(define-minor-mode qooxdoo-minor-mode
  nil                 ;default docstring
  nil                 ;initial value
  qooxdoo-mode-name   ;mode line indicator
  qooxdoo-mode-keymap ;keymap
  :group 'qooxdoo)

(defun qooxdoo-minor-mode-on ()
  (interactive)
  (set (make-local-variable yas/mode-symbol) qooxdoo-js-mode)
  (qooxdoo-minor-mode t))

(defun qooxdoo-minor-mode-off ()
  (interactive)
  (qooxdoo-minor-mode nil))

(provide 'qooxdoo)
;;; qooxdoo.el ends here
