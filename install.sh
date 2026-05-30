#!/usr/bin/env bash

VIM_AUTOLOAD_PATH="$HOME/.vim/autoload"
VIM_BUNDLE_PATH="$HOME/.vim/bundle"
VIM_PATHOGEN_URL="https://tpo.pe/pathogen.vim"
VIM_PLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
FISH_CONF_D_PATH="$HOME/.config/fish/conf.d"
FISH_DOTFILES_PATH="$FISH_CONF_D_PATH/dotfiles.fish"
DOTFILES_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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

mkdir -p $HOME/.config/ghostty
ln -sfn $PWD/ghostty-config $HOME/.config/ghostty/config
echo "Linked ghostty config"

mkdir -p $HOME/.aws
ln -sfn $PWD/aws-config $HOME/.aws/config
echo "Linked aws config"

mkdir -p $VIM_AUTOLOAD_PATH $VIM_BUNDLE_PATH
curl -LSso $VIM_AUTOLOAD_PATH/pathogen.vim $VIM_PATHOGEN_URL
curl -LSso $VIM_AUTOLOAD_PATH/plug.vim $VIM_PLUG_URL
echo "Linked vim plugin scripts."

mkdir -p "$FISH_CONF_D_PATH"
cat > "$FISH_DOTFILES_PATH" <<EOF
set -g fish_function_path "$DOTFILES_PATH/fish_functions" \$fish_function_path
set -gx VOLTA_HOME "\$HOME/.volta"
fish_add_path -g \$VOLTA_HOME/bin
EOF
echo "Prepended fish functions path and configured Volta."

vim +PlugInstall +qall
echo "Installed vim plugins."

echo "Installing brew packages..."
echo
brew bundle install
echo "Installed brew packages."

echo
echo "Install complete."

exit
