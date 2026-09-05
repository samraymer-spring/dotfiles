#!/bin/zsh

#################
# Shell commands
#################

alias ls='ls --color'
alias ll='ls -Al --color'
alias l='ls -Alt --color'
alias grep='grep --color'
alias egrep='egrep --color'
alias fgrep='fgrep --color'

############
# Git stuff
############

alias g='git'
alias gd='git diff'
alias gst='git status'
alias gpsup='git push origin head --set-upstream'
alias gpoh='git push origin head'
alias gst='git status'
alias gsp='git stash pop'
alias gapa='git add --patch --all'
alias gaa='git add --all'

function gco() {
    git checkout $(
        git branch  --sort=-committerdate |
         grep -v "$(git rev-parse --abbrev-ref HEAD)" |
         fzf --height=20% --reverse --info=inline
    )
}

########
# Kitty
########

alias icat="kitty +kitten icat --align=left"

######
# nvim
#####
alias vi=nvim
alias vim=nvim

########
# Claude
########

# disable mouse tracking
alias unmouse='printf "\e[?1000l\e[?1003l\e[?1006l"'
alias claude='command claude; unmouse'

