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
* reboot

---
  
* install iterm2
   * `brew cask install iterm2`
   * `ssh-keygen -t ecdsa -b 521`
   * `mkdir -p ~/other_projects`
   * `brew install bash`
     * set default profile login command to `/usr/local/bin/bash`

---

* install command line apps
  * `brew install git wget gpg tmux mobile-shell coreutils vim rsync`
* set up environment
  * add new [pubkey](https://github.com/settings/keys) to github
  * clone [configs repo](https://github.com/dmerrick/configs)
     * `rm ~/.bashrc ~/.bash_profile`
     * `setup.sh`
  * set up vim
     * `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
     * open vim
       * run `:PluginInstall`
  * clone [git-prompt repo](https://github.com/dmerrick/git-prompt)
  
  
---

* set up workspace
  * install rvm
    * `command curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -`
    * `curl -sSL https://get.rvm.io | bash -s stable`
  * `rvm install 2.6 # or whatever is latest`
  * `rvm --default use 2.6`
  * `rvm @global do gem install tmuxinator lolcat`
  * `brew install reattach-to-user-namespace watch`
  * open iterm
    * duplicate default iterm profile
    * call it 'Workspace', set as default
    * send text at start: `mux s workspace`

---

* open iterm
  * `brew cask install electric-sheep flux macvim spectacle transmit vlc lastfm mac2imgur macid rescuetime fuzzyclock`
* open rescuetime
  * set up
* open flux
  * set up
* open mac2imgur
  * set up
* open macid
  * set up
* open lastfm
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
  * `brew cask install chefdk hipchat slack skype packer vagrant virtualbox postgres # etc...`

---

* optional
  * `brew cask install apple-events battle-net docker keycastr mactex messenger spotify steam transmission plex-media-player`
* empty downloads directory
* reboot
 
