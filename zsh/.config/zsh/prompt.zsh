# Enable zsh hooks and vcs info functionality
autoload -Uz add-zsh-hook vcs_info

# Enable prompt substitution
setopt prompt_subst

# Get vcs info before showing prompt
add-zsh-hook precmd vcs_info

zstyle ':vcs_info:*' check-for-changes true

# asterisk in unstaged state
zstyle ':vcs_info:*' unstagedstr ' *'
# plus in staged state
zstyle ':vcs_info:*' stagedstr ' +'

# zstyle ':vcs_info:*' formats ' %s(%F{red}%b%f)' # git(main)
# catchall vcs info
zstyle ':vcs_info:*' formats ' %F{2}%s%F{7}:%F{2}(%F{1}%b%u%c%F{2})%f'
# git specific vcs info
zstyle ':vcs_info:git:*' formats ' %F{2}(%F{1}%b%u%c%F{2})%f'
# vcs info during git action
zstyle ':vcs_info:git:*' actionformats ' %F{2}(%F{1}%b|%a%u%c%F{2})%f'

tarot_file=$(find ~/dotfiles/assets/Cards/**/*.png -maxdepth 1 | shuf | head -n 1)
icat "$tarot_file"

PROMPT='%n@%m %1~${vcs_info_msg_0_} λ '
