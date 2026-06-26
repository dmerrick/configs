# DANA'S CONFIGS

My dotfiles and other miscellaneous configs.

Symlinks will be created from your homedir to this project. Your existing setup (if any) will not be removed.

For a complete guide on setting up a Mac, see [Dana's Workstation Runlist](https://gist.github.com/dmerrick/5275190)

## How to Install

* Clone this repo into your homedir
* `cd ~/configs`
* Make sure we have [GNU Stow](https://www.gnu.org/software/stow/)
  * `brew install stow  # or apt or whatever`
* `stow bash zsh git ghostty ruby tmux vim ssh other`


## SwiftBar plugins

The `swiftbar` package holds my menu-bar plugins (build-status indicators, etc).
[SwiftBar](https://github.com/swiftbar/SwiftBar) is the menu-bar runner; the plugins
themselves are written to the generic **[xbar](https://github.com/matryer/xbar)** plugin
format (formerly **BitBar**) — plain scripts that print menu lines to stdout, with
`<xbar.*>` metadata in the header. That format is portable across SwiftBar / xbar / BitBar.

SwiftBar reads its plugins from a folder you point it at (mine is `~/Documents/Swiftbar`).
Unlike the other packages, that target folder is **not** created by Stow — SwiftBar makes
it on first launch (or create it and set it as the plugin folder in SwiftBar's prefs)
*before* stowing, so the symlinks have somewhere to land:

* `stow swiftbar`

The filename cadence (`name.1m.sh`, `name.1h.sh`) is the xbar refresh interval.


## Migrating from setup.sh to GNU Stow
* Find the files we need to remove
  * `stow bash git ruby tmux vim other 2>&1 | awk '/not owned/ {print $NF}'`
* Remove those files
* Install using instructions above


## How to Update

* `confsync`
