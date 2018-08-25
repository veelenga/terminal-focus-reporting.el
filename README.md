## terminal-focus-reporting.el

Make Emacs play nicely with iTerm2 and tmux.

This plugin restores `focus-in-hook`, `focus-out-hook` functionality.
Now Emacs can save when the terminal loses a focus, even if it's inside the tmux.

## Usage

1. Install it:

```emacs-lisp
(terminal-focus-reporting :location
  (recipe :fetcher github :repo "veelenga/terminal-focus-reporting.el"))
```

2. Add code to the emacs config file:

```emacs-lisp

(unless (display-graphic-p)
  (require 'terminal-focus-reporting)
  (terminal-focus-reporting-activate))
```
