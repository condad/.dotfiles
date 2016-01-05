# Bash Startup Script
alias vi="mvim -v"
alias pyclean="rm *.pyc"

# Vim Mode for Term
set editing-mode vi
set keymap vi-command

PS1="\[\033[36m\]con\[\033[m\]@\[\033[33;1m\]\w\[\033[m\]>"

# Goodfoot Remote aliases
alias invoice.py="vim scp://goodfop0@goodfootdelivery.com//home2/goodfop0/gfd_invoicing/invoice.py"

# Virtual Env Wrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/workspace
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
. /usr/local/bin/virtualenvwrapper_lazy.sh
clear
