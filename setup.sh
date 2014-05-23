#!/bin/sh

DOT_FILES=".gemrc .gitconfig .gitignore_global .gvimrc .irbrc .tmux.conf .vim .vimrc .vrapperrc .zshrc .my.cnf"

for file in $DOT_FILES
do
    ln -s $HOME/dotfiles/$file $HOME
done

git submodule init
git submodule update
