# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '(%b)'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%(?.%F{green}√.%F{red}?%?)%f ${vcs_info_msg_0_} %B%F{240}%1~%f%b %# '
# PROMPT='${PWD/#$HOME/~} ${vcs_info_msg_0_} > '

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# add homebrew path
#TODO: only on darwin
export PATH="/opt/homebrew/bin:$PATH"

# makes git 66% smaller
# (and shows git status if no args)
g() {
 if [[ $# == '0' ]]; then
   git status -sb
 else
   git "$@"
 fi
}

bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
