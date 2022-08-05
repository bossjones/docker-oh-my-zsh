export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

plugins=(
    direnv
    git
    asdf
    fd
    colored-man-pages
)
# kubectl
# zsh-hooks/zsh-hooks

ZSH_THEME="crunch"

source $ZSH/oh-my-zsh.sh

bindkey "^R" history-incremental-search-backward

# export PATH="/root/.local/bin:$PATH"

path+=($HOME/bin)
path+=($HOME/.bin)
path+=($HOME/.local/bin)
path+=($HOME/.fnm)
path+=(/usr/local/sbin)
path+=(/usr/local/bin)
path+=(/usr/sbin)
path+=(/usr/bin)
path+=(/sbin)
path+=(/bin)

# added 12/17/2020 ( not sure if its going to cause trouble )
# SOURCE: https://github.com/eddiezane/lunchy/issues/57
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit