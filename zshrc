# Common aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Prompt settings
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
PROMPT='%F{green}%*%f %F{yellow}%~%f %F{red}${vcs_info_msg_0_}%f> '

# Vim mode setting
# TOOD: Check if homebrew is installed first
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

ZVM_VI_ESCAPE_BINDKEY=kj
ZVM_VI_INSERT_ESCAPE_BINDKEY=$ZVM_VI_ESCAPE_BINDKEY
ZVM_VI_VISUAL_ESCAPE_BINDKEY=$ZVM_VI_ESCAPE_BINDKEY

# Add volta to path
path=("$HOME/.volta/bin" $path)
