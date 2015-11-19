# Bash Startup Script
alias vi="mvim -v"
alias pyclean="rm *.pyc"

# Vim Mode for Term
set editing-mode vi
set keymap vi-command

PS1="\[\033[36m\]con\[\033[m\]@\[\033[33;1m\]\w\[\033[m\]>"

# Goodfoot Remote aliases
alias invoice.py="vim scp://goodfop0@goodfootdelivery.com//home2/goodfop0/gfd_invoicing/invoice.py"
