#
## 
###		BASH STARTUP SCRIPT
## 
#


alias ls='ls -G'
alias mv='mv -i'
alias cp='cp -i'

# Remove Compiled Python Files
alias pyclean="rm *.pyc"

# My Prompt
PS1="\[\033[36m\]\u\[\033[m\]@\[\033[33;1m\]\w\[\033[m\]>"

# Virtual Env Wrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/lab
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh

# Initialize VirtualEnvWrapper
. /usr/local/bin/virtualenvwrapper_lazy.sh
clear
