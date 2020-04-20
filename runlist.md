### Dana's Workstation Runlist

* go through new user flow
  * log in to iCloud
    * do _not_ enable iCloud Keychain
  * don't turn on filevault yet
    * it takes a while and you can't run updates until it's done
* check for/install updates

---

* open terminal
  * run homebrew install script
    * `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
  * install chrome
    * `brew cask install google-chrome`
    * sign in with google account
  * install resilio-sync & 1password
    * `brew cask install resilio-sync 1password`
    * set up resilio-sync
    * set up 1password
      * install browser extensions if necessary

---

* open system preferences
  * sharing
     * set hostname
     * enable screen sharing
     * enable remote login
  * iCloud
     * turn on/off services as needed
  * security
     * turn on screensaver password
     * turn on filevault
     * enable location services
     * allow Apple Watch to unlock
* reboot if filevault turned on

---
  
* install iterm2
   * `brew cask install iterm2`
   * `ssh-keygen -t ecdsa -b 521`


---

* install command line apps
  * `brew install bash git wget gpg tmux mobile-shell coreutils vim rsync jq ack htop keychain rename telnet stow`
* set up environment
  * add new [pubkey](https://github.com/settings/keys) to github
  * clone [configs repo](https://github.com/dmerrick/configs)
     * `rm ~/.bashrc ~/.bash_profile`
     * `stow bash git ruby tmux vim`
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
  * install rvm
    * `command curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -`
    * `curl -sSL https://get.rvm.io | bash -s stable`
  * `rvm install 2.6 # or whatever is latest`
  * `rvm --default use 2.6`
  * `rvm @global do gem install tmuxinator lolcat`
  * `brew install reattach-to-user-namespace watch neofetch`
  * open iterm
    * go to preferences
    * enable "Load preferences from folder" and "save changes to folder on exit"
    * send text at start: `tmuxinator s workspace`

---

* open iterm
  * `brew cask install electric-sheep flux spectacle transmit vlc mac2imgur rescuetime fuzzyclock omnifocus`
* open rescuetime
  * set up
* open flux
  * set up
* open mac2imgur
  * set up
* open omnifocus
  * set up
* open spectacle
* open fuzzyclock
* open system preferences
  * set up electic sheep
  * disable system clock
  * add fuzzyclock to startup items

---

* install work stuff if necessary
  * `mkdir -p ~/work`
  * `brew cask install slack skype packer vagrant virtualbox postgres docker chefdk hipchat # etc...`

---

* hide desktop icons
  * `defaults write com.apple.finder CreateDesktop false && killall Finder`
* drag unnecessary icons off dock

---

* optional
  * `brew cask install apple-events battle-net keycastr mactex messenger spotify steam transmission plex-media-player calibre discord keybase obs soundflower tunnelblick transmit firefox`
  * `brew install fortune cowsay chirp ffmpeg gifcicle sl youtube-dl`
* empty downloads directory
* reboot
 
