# tmux-bash-history

A tmux plugin for saving history and running commands for each pane.

## Installation
### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

```shell
set -g @plugin 'BSteffaniak/tmux-bash-history'
```

Hit `prefix + I` to fetch the plugin and source it.

### Manual Installation

Clone the repo:

```shell
$ git clone https://github.com/BSteffaniak/tmux-bash-history ~/clone/path
```

Add this line to the bottom of `.tmux.conf`:

```shell
run-shell ~/clone/path/tmux-bash-history.tmux
```

Reload TMUX environment:

```shell
# type this in terminal
$ tmux source-file ~/.tmux.conf
```

### Options

```tmux
# Change the default (~/.bash_history.d/) bash history home location to a custom one.
set -g @bash-history-home ~/path/to/dir
```
