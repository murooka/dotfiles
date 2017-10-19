#!/bin/bash

set -ue

# 設定ファイル類の準備
DOT_FILES=(.gemrc .gitconfig .gitignore_global .gvimrc .irbrc .tmux.conf .vim .vimrc .vrapperrc .zshrc .my.cnf .emacs.d .hammerspoon)
for file in "${DOT_FILES[@]}"
do
    [ ! -e "$HOME/$file" ] && ln -s "$HOME/dotfiles/$file" "$HOME"
done

mkdir -p ~/.vim_backup
mkdir -p ~/bin
mkdir -p ~/.config

[ ! -e "$HOME/.config/nvim" ] && ln -s "$HOME/dotfiles/.vim" "$HOME/.config/nvim"


git submodule init
git submodule update

