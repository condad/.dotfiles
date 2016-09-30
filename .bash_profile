#
## 
###		BASH STARTUP SCRIPT
## 
#


alias vi='vim'
alias ls='ls -G'
alias mv='mv -i'
alias cp='cp -i'
alias mvim='mvim -p'

# commands
alias pyclean="find . -name "*.pyc" -delete"

# My Prompt
PS1="\[\033[36m\]\u\[\033[m\]@\[\033[33;1m\]\w\[\033[m\]>"
set -o vi

# Virtual Env Wrapper
export EDITOR=vim
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/lab
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh

# Add PostGreSQL Executables
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/9.5/bin"

# Initialize VirtualEnvWrapper
. /usr/local/bin/virtualenvwrapper_lazy.sh

clear
