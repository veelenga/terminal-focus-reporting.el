## terminal-focus-reporting.el

Minor mode for terminal focus reporting.

This plugin restores `focus-in-hook`, `focus-out-hook` functionality.
Now Emacs can, for example, save when the terminal loses a focus, even if it's inside the tmux.

## Usage

Add code to the Emacs config file:

```emacs-lisp

(unless (display-graphic-p)
  (terminal-focus-reporting-mode))
```
