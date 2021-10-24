# DANA'S CONFIGS

My dotfiles and other miscellaneous configs.

Symlinks will be created from your homedir to this project. Your existing setup (if any) will not be removed.

For a complete guide on setting up a Mac, see [Dana's Workstation Runlist](https://gist.github.com/dmerrick/5275190)

## How to Install

* Clone this repo into your homedir
* `cd ~/configs`
* Make sure we have [GNU Stow](https://www.gnu.org/software/stow/)
  * `brew install stow  # or apt or whatever`
* `stow bash zsh git ruby tmux vim ssh other`


## Migrating from setup.sh to GNU Stow
* Find the files we need to remove
  * `stow bash git ruby tmux vim other 2>&1 | awk '/not owned/ {print $NF}'`
* Remove those files
* Install using instructions above


## How to Update

* `confsync`
