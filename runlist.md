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
  * icloud
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

---

* open app store
  * log in
* install command line apps
  * `brew install git wget gpg tmux mobile-shell`
  * `brew tap homebrew/dupes`
  * `brew install rsync`
* install rvm
  * `gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3`
  * `\curl -sSL https://get.rvm.io | bash -s stable`
* log in to github
  * add new [pubkey](https://github.com/settings/keys)
  * clone [configs repo](https://github.com/dmerrick/configs)
     * run `rm ~/.bashrc ~/.bash_profile`
     * run `setup.sh`
  * clone [git-prompt repo](https://github.com/dmerrick/git-prompt)

---

electric-sheep flux macvim slack spectacle transmit
chefdk hipchat packer vagrant virtualbox

* open safari
  * install gitx
     * enable terminal usage
  * install f.lux
  * install propane
  * install hipchat
  * install skype
  * install cyberduck
  * install VLC
  * install last.fm scrobbler
  * install fuzzyclock
     * set to fluid english
     * disable system clock
  * install virtualbox

---

* optional
  * install macvim
  * spotify
  * steam
  * plex media server
  * tickermenu
  * transmission
* empty downloads directory
* reboot
 