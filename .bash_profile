# ~/.bash_profile

# get the aliases and functions from .bashrc
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# user-specific environment and startup programs

# include root utils in PATH
export PATH=$PATH:$HOME/bin:/sbin:/usr/sbin

# RVM settings
[[ -s ~/.rvm/scripts/rvm ]] && source ~/.rvm/scripts/rvm
#export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH

# if we have keychain then we rock
if [ "$(which keychain 2>/dev/null)" ]; then
  eval `keychain --ignore-missing -q --eval ~/.ssh/id_rsa ~/.ssh/id_dsa`
fi

# TMUX
if we_have tmux; then
  # if not inside a tmux session, and if no session is started, start a new session
  test -z "$TMUX" && (tmux attach || tmux new-session)
fi

#export CDPATH=.:$HOME/work

#if [ "$DISPLAY" ]; then
# if [ "$(which tpb 2>/dev/null)" ]; then
#   tpb -d &
# fi
# #set defaluts for x crap
# if [ `uname` != 'Darwin' ]; then
#   xrdb -load ~/.Xresources
# fi
#fi

# os x stuff down here
if [ `uname` == 'Darwin' ]; then
  # Adding an appropriate PATH variable for use with MacPorts.
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH
  # Adding an appropriate MANPATH variable for use with MacPorts.
  export MANPATH=/opt/local/share/man:$MANPATH

  # custom ls colors
  export CLICOLOR=1
  export LSCOLORS=FxFxCxDxBxegedabagacfH # pretty much only for the last 2 chars

  # needed for SSD drives
  ulimit -n 1024
fi
