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

alias aws-core="aws-vault exec reverie-core --no-session"
alias aws-core-west-2="aws-vault exec reverie-core --no-session --region=us-west-2"
alias aws-legacy="aws-vault exec reverie-legacy --no-session"
# alias aws-prod-admin="aws-vault exec reverie-prod-1-admin --no-session"
alias aws-prod-west-2-admin="aws-vault exec reverie-prod-1-admin --no-session --region=us-west-2"
alias aws-prod-west-2="aws-vault exec reverie-prod-1 --no-session --region=us-west-2"
alias aws-prod="aws-vault exec reverie-prod-1 --no-session"
# alias aws-roche-admin="aws-vault exec roche-prod-1-admin --no-session"
# alias aws-roche-ci="aws-vault exec roche-prod-1-ci --no-session"
# alias aws-roche="aws-vault exec roche-prod-1 --no-session"
alias aws-shared-admin="aws-vault exec reverie-shared-admin --no-session"
alias aws-shared="aws-vault exec reverie-shared --no-session"
alias aws-shared-west-2-admin="aws-vault exec reverie-shared-admin --no-session --region=us-west-2"
alias aws-stage-admin="aws-vault exec reverie-stage-1-admin --no-session"
alias aws-stage-ci="aws-vault exec reverie-stage-1-ci --no-session"
alias aws-stage="aws-vault exec reverie-stage-1 --no-session"
alias aws-stage-west-2="aws-vault exec reverie-stage-1 --no-session --region=us-west-2"
alias aws-stage-west-2-admin="aws-vault exec reverie-stage-1-admin --no-session --region=us-west-2"
# alias aws-genentech-admin="aws-vault exec genentech-prod-1-admin --no-session"
# alias aws-genentech="aws-vault exec genentech-prod-1 --no-session"

alias tf-core="cd ~/work/infra/terraform/aws/reverie-core/us-east-1 && aws-core"
alias tf-core-west-2="cd ~/work/infra/terraform/aws/reverie-core/us-west-2 && aws-core-west-2"
# alias tf-prod="cd ~/work/infra/terraform/aws/reverie-prod-1 && GODEBUG=asyncpreemptoff=1 aws-prod-admin"
alias tf-prod-west-2="cd ~/work/infra/terraform/aws/reverie-prod-1/us-west-2 && GODEBUG=asyncpreemptoff=1 aws-prod-west-2-admin" #--duration=6h
# alias tf-roche="cd ~/work/infra/terraform/aws/roche-prod-1 && aws-roche-admin"
alias tf-shared="cd ~/work/infra/terraform/aws/reverie-shared/us-east-1 && GODEBUG=asyncpreemptoff=1 aws-shared-admin"
alias tf-shared-west-2="cd ~/work/infra/terraform/aws/reverie-shared/us-west-2 && GODEBUG=asyncpreemptoff=1 aws-shared-west-2-admin"
alias tf-stage="cd ~/work/infra/terraform/aws/reverie-stage-1/us-east-1 && GODEBUG=asyncpreemptoff=1 aws-stage-admin"
alias tf-stage-west-2="cd ~/work/infra/terraform/aws/reverie-stage-1/us-west-2 && GODEBUG=asyncpreemptoff=1 aws-stage-west-2-admin"
# alias tf-genentech="cd ~/work/infra/terraform/aws/genentech-prod-1 && aws-genentech-admin"

alias helm-roche="aws-roche -- helm --kube-context roche-prod-1-eks-cluster"
alias helm-prod="aws-prod-west-2 -- helm --kube-context reverie-prod-1-eks-cluster"
alias helm-stage="aws-stage -- helm --kube-context reverie-stage-1-eks-cluster"
alias k8s-roche="aws-roche -- kubectl --context roche-prod-1-eks-cluster"
alias k8s-prod="aws-prod-west-2 -- kubectl --context reverie-prod-1-eks-cluster"
alias k8s-stage-temp="aws-stage -- kubectl --context reverie-stage-1-temp-eks-cluster"
alias k8s-stage="aws-stage -- kubectl --context reverie-stage-1-eks-cluster"
alias tail-roche="aws-roche -- kubetail --context roche-prod-1-eks-cluster"
alias tail-stage="aws-stage -- kubetail --context reverie-stage-1-eks-cluster"
# alias k8s-stage="aws-stage-admin -- aws eks update-kubeconfig --name reverie-stage-1-eks-cluster >/dev/null && aws-stage-admin -- kubectl"
# alias k8s-roche="aws-roche-admin -- aws eks update-kubeconfig --name roche-prod-1-eks-cluster >/dev/null && aws-roche-admin -- kubectl"
# alias k8s-genentech="cd ~/work/infra/k8s && aws-genentech-admin -- kubectl"
alias k8s-legacy="aws-legacy -- aws eks update-kubeconfig --name reverie-eks-cluster >/dev/null && aws-legacy -- kubectl"
alias k8s-legac-sai="aws-legacy -- aws eks update-kubeconfig --name reverie-sai-sharedinfra-cluster >/dev/null && aws-legacy -- kubectl"

alias k9s-stage="aws-stage -- \k9s --logoless --context reverie-stage-1-eks-cluster"
alias k9s-roche="aws-roche -- \k9s --logoless --context roche-prod-1-eks-cluster"
alias k9s-prod="aws-prod-west-2 -- \k9s --logoless --context reverie-prod-1-eks-cluster"

alias popeye-stage="aws-stage -- popeye --context reverie-stage-1-eks-cluster"
alias popeye-prod="aws-prod-west-2 -- popeye --context reverie-prod-1-eks-cluster"

alias k8s-stage-ci="aws-stage-ci -- aws eks update-kubeconfig --region us-east-1 --name reverie-stage-1-eks-cluster >/dev/null && aws-stage-ci -- kubectl"
alias k8s-roche-ci="aws-roche-ci -- aws eks update-kubeconfig --region us-east-1 --name roche-prod-1-eks-cluster >/dev/null && aws-roche-ci -- kubectl"

alias k8s-dana-stage="aws-stage -- kubectl --context k3d-adanalife-stage"
alias helm-dana-stage="aws-stage -- helm --kube-context k3d-adanalife-stage"

alias login-core="aws-vault login reverie-core --duration=12h"
alias login-legacy="aws-vault login reverie-legacy --duration=12h"
alias login-stage="aws-vault login reverie-stage-1 --duration=12h"
alias login-stage-chemist="aws-vault login reverie-stage-1-chemist --duration=12h"
alias login-stage-admin="aws-vault login reverie-stage-1-admin"
alias login-roche="aws-vault login roche-prod-1 --duration=12h"
alias login-roche-chemist="aws-vault login roche-prod-1-chemist --duration=12h"
alias login-roche-admin="aws-vault login roche-prod-1-admin"
# alias login-genentech="aws-vault login genentech-prod-1"
# alias login-genentech-admin="aws-vault login genentech-prod-1-admin"

alias aws-dana-core="aws-vault exec adanalife-core --no-session"
alias aws-dana-stage="aws-vault exec adanalife-stage --no-session"
alias aws-dana-stage-developer="aws-vault exec adanalife-stage-developer --no-session"
alias aws-dana-prod="aws-vault exec adanalife-prod --no-session"
alias aws-dana-prod-developer="aws-vault exec adanalife-prod-developer --no-session"
alias tf-dana-core="cd ~/adanalife/infra/terraform/core && aws-dana-core"
alias tf-dana-stage="cd ~/adanalife/infra/terraform/stage-1 && aws-dana-stage"
alias tf-dana-prod="cd ~/adanalife/infra/terraform/prod-1 && aws-dana-prod"

alias devenv="source activate reverie_env && aws-legacy -- ~/work/infra/bin/rit-devenv"

alias plex-restart='ssh hawthorne -- open -a "/Applications/Plex\ Media\ Server.app"'

alias retry='while [ $? -ne 0 ]; do fc -e "#"; done'

source /opt/homebrew/opt/asdf/libexec/asdf.sh

source ~/.zshrc.conda

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/dmerrick/miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/dmerrick/miniconda/etc/profile.d/conda.sh" ]; then
        . "/Users/dmerrick/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/Users/dmerrick/miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

