;;; brutality.el --- Make Emacs play nicely with iTerm2 and tmux.

;; Copyright © 2018 Vitalii Elenhaupt <velenhaupt@gmail.com>
;; Author: Vitalii Elenhaupt
;; URL: https://github.com/veelenga/brutality.el
;; Keywords: convenience
;; Package-Requires: ((emacs "24.4"))

;; This file is not part of GNU Emacs.

;;; License:

;; This program is free software: you can redistribute it and/or modify
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

;; Usage:

;;; Code:

(defgroup brutality nil
  "Make Emacs play nicely with iTerm2 and tmux"
  :prefix "brutality-"
  :group 'convenience
  :group 'tools
  :link '(url-link :tag "GitHub" "https://github.com/veelenga/brutality"))

(defconst brutality-focus-reporting-enable-seq "\e[?1004h")
(defconst brutality-focus-reporting-disable-seq "\e[?1004l")

(defun brutality--apply-to-terminal (seq)
  "Send escape sequence SEQ to terminal."
  (when (and seq (stringp seq))
    (send-string-to-terminal seq)
    (send-string-to-terminal seq)))

(defun brutality-enable-focus-reporting ()
  "Enables focus reporting in a terminal."
  (brutality--apply-to-terminal brutality-focus-reporting-enable-seq))

(defun brutality-disable-focus-reporting ()
  "Disables focus reporting in a terminal."
  (brutality--apply-to-terminal brutality-focus-reporting-disable-seq))

(global-set-key (kbd "M-[ i") (lambda () (interactive) (handle-focus-in 0)))
(global-set-key (kbd "M-[ o") (lambda () (interactive) (handle-focus-out 0)))

;;;###autoload
(defun brutality-activate ()
  "Enables Brutality"
  (interactive)
  (brutality-enable-focus-reporting))

;;;###autoload
(defun brutality-deactivate ()
  "Disables Brutality"
  (interactive)
  (brutality-disable-focus-reporting))

(provide 'brutality)
;;; brutality.el ends here
