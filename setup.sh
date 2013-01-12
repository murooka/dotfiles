#!/bin/sh

DOT_FILES=".gitconfig .gitignore_global .gvimrc .vimrc .zshrc .vim"

for file in $DOT_FILES
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

git submodule init
git submodule update
