#!/usr/bin/env bash

VIM_AUTOLOAD_PATH="$HOME/.vim/autoload"
VIM_BUNDLE_PATH="$HOME/.vim/bundle"
VIM_PATHOGEN_URL="https://tpo.pe/pathogen.vim"
VIM_PLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
FISH_FUNCTION_PATH="$HOME/.config/fish/functions"

echo "Installing dotfiles..."
echo

ln -sF $PWD/bash_profile $HOME/.bash_profile
ln -sF $PWD/bashrc $HOME/.bashrc
echo "Linked bash startup scripts."

ln -sF $PWD/vimrc $HOME/.vimrc
echo "Linked vim startup script."

mkdir -p $VIM_AUTOLOAD_PATH $VIM_BUNDLE_PATH
curl -LSso $VIM_AUTOLOAD_PATH/pathogen.vim $VIM_PATHOGEN_URL
curl -LSso $VIM_AUTOLOAD_PATH/plug.vim $VIM_PLUG_URL
echo "Linked vim plugin scripts."

for file_path in $PWD/fish_functions/*.fish; do
  file_name=`basename $file_path`
  ln -sF $file_path $FISH_FUNCTION_PATH/$file_name
done
echo "Linked fish functions."

echo
echo "Install complete."

exit
