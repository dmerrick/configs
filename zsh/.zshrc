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

export PATH="$PATH:$HOME/bin"

source ~/.aliases

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

# cread tis: https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org

# ignore case when globbing/tab-completing
setopt NO_CASE_GLOB
# add "cd" if you "run" a dir name
setopt AUTO_CD
# extra info in history
setopt EXTENDED_HISTORY

# enable correction suggestions
setopt CORRECT
setopt CORRECT_ALL

# share history across multiple zsh sessions
setopt SHARE_HISTORY
# append to history
setopt APPEND_HISTORY
# adds commands as they are typed, not at shell exit
# setopt INC_APPEND_HISTORY
# do not store duplications
setopt HIST_IGNORE_DUPS
#ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# removes blank lines from history
setopt HIST_REDUCE_BLANKS

# compdef g=git

#TODO: make these match bash?
SAVEHIST=500000
HISTSIZE=200000
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history

alias k8s-dana-stage="aws-stage -- kubectl --context k3d-adanalife-stage"
alias helm-dana-stage="aws-stage -- helm --kube-context k3d-adanalife-stage"

alias aws-dana-core="aws-vault exec adanalife-core --no-session"
alias aws-dana-stage="aws-vault exec adanalife-stage --no-session"
alias aws-dana-stage-developer="aws-vault exec adanalife-stage-developer --no-session"
alias aws-dana-prod="aws-vault exec adanalife-prod --no-session"
alias aws-dana-prod-developer="aws-vault exec adanalife-prod-developer --no-session"
alias tf-dana-core="cd ~/adanalife/infra/terraform/core && aws-dana-core"
alias tf-dana-stage="cd ~/adanalife/infra/terraform/stage-1 && aws-dana-stage"
alias tf-dana-prod="cd ~/adanalife/infra/terraform/prod-1 && aws-dana-prod"

alias devenv="ssh -t devenv-prod-cpu -- tmux new -A -s workspace"
# alias devenv-up="aws-prod-west-2 -- aws ec2 start-instances --instance-ids i-0c15b75d6834e2a89 | jq -r '.StartingInstances[0].CurrentState.Name'"
# alias devenv-down="aws-prod-west-2 -- aws ec2 stop-instances --instance-ids i-0c15b75d6834e2a89 | jq -r '.StoppingInstances[0].CurrentState.Name'"

alias plex-restart='ssh home -- open -a "/Applications/Plex\ Media\ Server.app"'

alias retry='while [ $? -ne 0 ]; do fc -e "#"; done'

# add atuin (fancy shell history)
eval "$(atuin init zsh --disable-up-arrow)"
