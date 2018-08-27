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

## How it works

Emacs and terminal communicate by sending and receiving special string sequences.

For example, if the program (emacs) sends to the terminal the text `<Esc>[?1004h`,
terminal enables "focus reporting" feature and sends special sequences to the program
when focus lost or restored.

This can be tested directly in the terminal executing this command:

```
$ echo -e "\e[?1004h" && read
```

and if we let terminal lose a focus and then restore it, we will see these commands sent back by the terminal:

```
^[[O^[[I
```

This plugin is able to enable and disable terminal focus reporting and can read special
commands from the terminal and execute needed hooks (`focus-in`, `focus-out`) when the terminal
fires focus lost or focus restored events respectively.
