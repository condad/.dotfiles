#!/usr/bin/env bash

VIM_AUTOLOAD_PATH="$HOME/.vim/autoload"
VIM_BUNDLE_PATH="$HOME/.vim/bundle"
VIM_PATHOGEN_URL="https://tpo.pe/pathogen.vim"
VIM_PLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
FISH_FUNCTION_PATH="$HOME/.config/fish/functions"

echo "Installing dotfiles..."
echo

ln -sfn $PWD/bash_profile $HOME/.bash_profile
if [ -f $HOME/.bashrc ]; then
  cat $PWD/bashrc >> $HOME/.bashrc
fi
echo "Linked bash startup scripts."

ln -sfn $PWD/zshrc $HOME/.zshrc
echo "Linked zsh startup script."

ln -sfn $PWD/vimrc $HOME/.vimrc
echo "Linked vim startup script."

ln -sfn $PWD/jq $HOME/.jq
echo "Linked jq module(s)."

mkdir -p $VIM_AUTOLOAD_PATH $VIM_BUNDLE_PATH
curl -LSso $VIM_AUTOLOAD_PATH/pathogen.vim $VIM_PATHOGEN_URL
curl -LSso $VIM_AUTOLOAD_PATH/plug.vim $VIM_PLUG_URL
echo "Linked vim plugin scripts."

for file_path in $PWD/fish_functions/*.fish; do
  file_name=`basename $file_path`
  ln -sfn $file_path $FISH_FUNCTION_PATH/$file_name
done
echo "Linked fish functions."

vim +PlugInstall +qall
echo "Installed vim plugins."

echo "Installing brew packages..."
echo
brew bundle install
echo "Installed brew packages."

echo
echo "Install complete."

exit
