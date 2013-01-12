#!/bin/sh

DOT_FILES=".gemrc .gitconfig ..gitignore_global .gvimrc .irbrc .tmux.conf .vim .vimrc .vrapperrc .zshrc"

for file in $DOT_FILES
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

git submodule init
git submodule update
