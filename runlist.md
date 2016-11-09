### Dana's Workstation Runlist

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
     * enable screen sharing
     * enable remote login
     * enable file sharing
     * set name if required
  * ibutt
     * turn on back to my mac
  * desktop & screen saver
     * configure resilio wallpaper folder
  * security
     * turn on screensaver password
     * turn on filevault
* reboot

---
  
* install iterm2
   * `brew cask install iterm2`
   * run `ssh-keygen -t ecdsa -b 521`
   * `mkdir ~/other_projects`
   * `mkdir ~/work`
   * `brew install bash`
     * set default profile login command to `/usr/local/bin/bash`

---

* install command line apps
  * `brew install git wget gpg tmux mobile-shell`
  * `brew tap homebrew/dupes`
  * `brew install rsync`
* install rvm
  * `gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3`
  * `\curl -sSL https://get.rvm.io | bash -s stable`
* set up github
  * add new [pubkey](https://github.com/settings/keys)
  * clone [configs repo](https://github.com/dmerrick/configs)
     * run `rm ~/.bashrc ~/.bash_profile`
     * run `setup.sh`
  * clone [git-prompt repo](https://github.com/dmerrick/git-prompt)
  
---

* set up workspace
  * run `rvm install 2.3 # or whatever is latest`
  * `rvm --default use 2.3`
  * `rvm @global do gem install tmuxinator lolcat`
  * open iterm
    * duplicate default iterm profile
    * call it 'Workspace', set as default
    * send text at start: `mux s workspace`

---

* open iterm
  * run `brew cask install electric-sheep flux macvim spectacle transmit gitx vlc lastfm mac2imgur macid messenger rescuetime`
* open system preferences
  * set up electic sheep
* open gitx
  * enable terminal usage
* open lastfm
  * set up

---

* install work stuff if necessary
  * run `brew cask install chefdk hipchat slack skype packer vagrant virtualbox postgres`

---

* open safari
  * install fuzzyclock
     * set to fluid english
     * disable system clock

---

* optional
  * `brew cask install apple-events battle-net docker keycastr mactex messenger spotify steam transmission`
  * plex

* empty downloads directory
* reboot
 