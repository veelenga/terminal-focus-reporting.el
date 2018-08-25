;;; terminal-focus-reporting.el --- Make Emacs play nicely with iTerm2 and tmux.

;; Copyright © 2018 Vitalii Elenhaupt <velenhaupt@gmail.com>
;; Author: Vitalii Elenhaupt
;; URL: https://github.com/veelenga/terminal-focus-reporting.el
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

(defgroup terminal-focus-reporting nil
  "Make Emacs play nicely with iTerm2 and tmux"
  :prefix "terminal-focus-reporting-"
  :group 'convenience
  :group 'tools
  :link '(url-link :tag "GitHub" "https://github.com/veelenga/terminal-focus-reporting.el"))

(defconst terminal-focus-reporting-enable-seq "\e[?1004h")
(defconst terminal-focus-reporting-disable-seq "\e[?1004l")

(defun terminal-focus-reporting--in-tmux? ()
  "Running in tmux."
  (getenv "TMUX"))

(defun terminal-focus-reporting--make-tmux-seq (seq)
  "Makes escape sequence SEQ for tmux."
  (let ((prefix "\ePtmux;\e")
        (suffix "\e\\"))
    (concat prefix seq suffix seq)))

(defun terminal-focus-reporting--make-focus-reporting-seq (mode)
  "Makes focus reporting escape sequence."
  (let ((seq (cond ((eq mode 'on) terminal-focus-reporting-enable-seq)
                  ((eq mode 'off) terminal-focus-reporting-disable-seq)
                  (t nil))))
    (if seq
        (progn
          (if (terminal-focus-reporting--in-tmux?)
              (terminal-focus-reporting--make-tmux-seq seq)
              seq))
      nil)))

(defun terminal-focus-reporting--apply-to-terminal (seq)
  "Sends escape sequence SEQ to a terminal."
  (when (and seq (stringp seq))
    (send-string-to-terminal seq)
    (send-string-to-terminal seq)))

;; These commands are sent by the terminal in focus reporting mode
(global-set-key (kbd "M-[ i") (lambda () (interactive) (handle-focus-in 0)))
(global-set-key (kbd "M-[ o") (lambda () (interactive) (handle-focus-out 0)))

;;;###autoload
(defun terminal-focus-reporting-activate ()
  "Enables terminal focus reporting."
  (interactive)
  (terminal-focus-reporting--apply-to-terminal (terminal-focus-reporting--make-focus-reporting-seq 'on)))

;;;###autoload
(defun terminal-focus-reporting-deactivate ()
  "Disables terminal focus reporting."
  (interactive)
  (terminal-focus-reporting--apply-to-terminal (terminal-focus-reporting--make-focus-reporting-seq 'off)))

;;;###autoload
(defalias 'tfr-on 'terminal-focus-reporting-activate)

;;;###autoload
(defalias 'tfr-off 'terminal-focus-reporting-deactivate)

(add-hook 'kill-emacs-hook 'terminal-focus-reporting-deactivate)

(provide 'terminal-focus-reporting)
;;; terminal-focus-reporting.el ends here
