# Enable command auto-completion
autoload -U compinit; compinit

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '(%b)'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%(?.%F{green}√.%F{red}?%?)%f ${vcs_info_msg_0_} %B%F{240}%1~%f%b %# '
# PROMPT='${PWD/#$HOME/~} ${vcs_info_msg_0_} > '
source "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
PS1='$(kube_ps1)'$PS1

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# add homebrew path
#TODO: only on darwin
export PATH="/opt/homebrew/bin:$PATH"

# Add custom bin directory to PATH
export PATH="$PATH:$HOME/bin"

# Source aliases if the file exists
if [ -f ~/.aliases ]; then
  source ~/.aliases
fi

# Custom git function to make git 66% smaller and show status if no args
g() {
 if [ $# -eq 0 ]; then
   git status -sb
 else
   git "$@"
 fi
}
compdef g=git

# Key bindings for history search
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Zsh options
setopt NO_CASE_GLOB          # Ignore case when globbing/tab-completing
setopt AUTO_CD               # Add "cd" if you "run" a dir name
setopt EXTENDED_HISTORY      # Extra info in history
setopt CORRECT               # Enable correction suggestions
setopt CORRECT_ALL           # Enable correction suggestions for all arguments
setopt SHARE_HISTORY         # Share history across multiple zsh sessions
setopt APPEND_HISTORY        # Append to history
# setopt INC_APPEND_HISTORY  # Adds commands as they are typed, not at shell exit
setopt HIST_IGNORE_DUPS      # Do not store duplications
setopt HIST_FIND_NO_DUPS     # Ignore duplicates when searching
setopt HIST_REDUCE_BLANKS    # Removes blank lines from history

# History settings
SAVEHIST=500000
HISTSIZE=200000
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history

# Aliases
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

# Set default editor to nvim if available
if type nvim &>/dev/null; then
  export EDITOR=nvim
fi

# Homebrew setup
if type brew &>/dev/null; then
  # Add homebrew path
  export PATH="/opt/homebrew/bin:$PATH"

  # Add k8s context to prompt
  source $(brew --prefix)/opt/kube-ps1/share/kube-ps1.sh
  KUBE_PS1_NS_ENABLE=false
  KUBE_PS1_SYMBOL_ENABLE=false
  KUBE_PS1_SUFFIX=') '
  PROMPT='$(kube_ps1)'$PROMPT # or RPROMPT='$(kube_ps1)'

  # Load zsh completions
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  autoload -Uz compinit
  compinit

  # Load zsh-autosuggestions
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

  # Load zsh-syntax-highlighting
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Atuin setup (fancy shell history)
if type atuin &>/dev/null; then
  eval "$(atuin init zsh --disable-up-arrow)"
fi

# Enable bash completion for specific commands
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/tk tk
