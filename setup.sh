#!/bin/sh

DOT_FILES=".gemrc .gitconfig .gitignore_global .gvimrc .irbrc .tmux.conf .vim .vimrc .vrapperrc .zshrc .my.cnf .emacs.d"

for file in $DOT_FILES
do
    ln -s $HOME/dotfiles/$file $HOME
done

mkdir -p ~/.vim_backup
mkdir -p ~/bin

git submodule init
git submodule update
