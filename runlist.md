### Dana's Workstation Runlist

* go through new user flow
  * log in to iCloud
    * do _not_ enable iCloud Keychain
  * enable FileVault
* check for/install updates

---

* open terminal
  * run homebrew install script
    * `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
  * install chrome
    * `brew install google-chrome`
    * sign in with google account
  * install resilio-sync & 1password
    * `brew tap homebrew/cask-versions`
    * `brew install resilio-sync 1password7`
    * set up resilio-sync
    * set up 1password
      * install browser extensions if necessary
  * install iterm2
    * `brew install iterm2`

---

* open system preferences
  * sharing
     * set hostname
     * enable screen sharing
     * enable remote login
  * iCloud
     * turn off photos sync
     * turn off keychain sync
     * turn off news
  * security
     * turn on screensaver password
     * enable location services
     * allow Apple Watch to unlock
  * keyboard
     * change capslock Modifier Key to ESC
     * disable spelling correction
     * disable capitalize words

---

* install command line apps
  * `brew install zsh git wget gpg tmux mosh coreutils nvim rsync jq ripgrep htop rename telnet stow bat lsd`
* set up environment
  * generate new pubkey
    * `ssh-keygen -t ecdsa -b 521`
  * add new pubkey [to github](https://github.com/settings/keys)
  * clone [configs repo](https://github.com/dmerrick/configs)
     * `rm ~/.bashrc ~/.bash_profile`
     * `stow zsh bash git ruby tmux vim`
   * add new key to authorized_keys
     * `cat ~/.ssh/id_ecdsa.pub >> ~/.ssh/authorized_keys`
     * `cd ~/configs && git commit authorized_keys`
  * set up vim
     * `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
     * open vim
       * run `:PluginInstall`
  * `mkdir -p ~/other_projects`
     * clone [git-prompt repo](https://github.com/dmerrick/git-prompt)
  
  
---

* set up workspace
  * `brew install reattach-to-user-namespace watch neofetch`
  * open iterm
    * go to preferences
    * enable "Load preferences from folder" and "save changes to folder on exit"

---

* open iterm
  * `brew install bartender transmit vlc rescuetime fuzzyclock omnifocus obsidian fantastical`
* open rescuetime
  * set up
* open omnifocus
  * set up
* open fuzzyclock
* open system preferences
  * set up electic sheep
  * disable system clock
  * add fuzzyclock to startup items

---

* `brew install mas`
* sign in to App Store
* `mas install  639968404 # Parcel`
* `mas install  441258766 # Magnet`
* `mas install  937984704 # Amphetamine`
* `mas install  993487541 # CARROT Weather`
* `mas install 1191449274 # ToothFairy`
* `mas install 1295203466 # Microsoft Remote Desktop`
* `mas install 1358823008 # Flighty`

---

* install work stuff if necessary
  * `mkdir -p ~/work`
  * `brew install slack packer postgres docker # etc...`

---

* hide desktop icons
  * `defaults write com.apple.finder CreateDesktop false && killall Finder`
* drag unnecessary icons off dock
* `open ~/..`
  * drag home dir into finder sidebar
* open Messages
  * enable messages in iCloud
  * open iPhone settings and enable SMS forwarding
* make chrome the default [`mailto://` handler](https://support.google.com/a/users/answer/9308783?hl=en)
* increase key repeat speed:
  * `defaults write -g InitialKeyRepeat -int 10`
  * `defaults write -g KeyRepeat -int 1`

---

* optional
  * `brew install apple-events battle-net keycastr mactex messenger spotify steam transmission plex-media-player calibre discord keybase obs soundflower tunnelblick transmit firefox chatterino signal`
  * `brew install fortune cowsay chirp ffmpeg gifcicle sl youtube-dl cmatrix`
* empty downloads directory
* reboot
