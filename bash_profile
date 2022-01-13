# BASH personal startup script

set -o vi

alias vi='vim'
alias ls='ls -G'
alias mv='mv -i'
alias cp='cp -i'
alias mvim='mvim -p'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'

# commands
alias python='python3'
alias pyclean="find . -name \"*.pyc\" -exec rm -f {} \;"

# Virtual Env Wrapper
export EDITOR=code

# Add PostGreSQL Executables
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.5/bin
export PATH=$PATH:/usr/local/sbin

# prompt
PS1="\[\033[1;36m\]\u\[\033[m\]@\[\033[1;33m\]\w\[\033[m\]>"

# pipenv
export PIPENV_VENV_IN_PROJECT=true
export PIPENV_DEFAULT_PYTHON_VERSION=3.6
alias pv='pipenv run python'

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

clear
