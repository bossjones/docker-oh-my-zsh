export ZSH="$HOME/.oh-my-zsh"

plugins=(
    direnv
    git
    kubectl
)

ZSH_THEME="crunch"

source $ZSH/oh-my-zsh.sh

bindkey "^R" history-incremental-search-backward

export PATH="/root/.local/bin:$PATH"