# Enable zsh hooks and vcs info functionality
autoload -Uz add-zsh-hook vcs_info

# Enable prompt substitution
setopt prompt_subst

# Get vcs info before showing prompt
add-zsh-hook precmd vcs_info

# zstyle ':vcs_info:*' formats ' %s(%F{red}%b%f)' # git(main)
zstyle ':vcs_info:*' formats ' %F{2}%s%F{7}:%F{2}(%F{1}%b%F{2})%f'

PROMPT='%n@%m %1~%F{red}${vcs_info_msg_0_}%f λ '
