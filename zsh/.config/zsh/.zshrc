#!/bin/zsh

# Source additional config files e.g. alias.zsh
source ${ZDOTDIR}/alias.zsh
source ${ZDOTDIR}/prompt.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add user-portable binaries at .local/bin, e.g. claude code
export PATH="$HOME/.local/bin:$PATH"

# set up pnpm
export PNPM_HOME="/Users/sam/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Homebrew global commands
eval "$(/opt/homebrew/bin/brew shellenv)"
source <(fzf --zsh)

# Change dir without `cd`
setopt autocd

################################################
##### stuff to run last or it will break!! #####
################################################

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load
