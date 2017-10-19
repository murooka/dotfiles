#!/bin/bash

set -ue

echo 'You should instal Xcode. Ready? [y(es)/n(o)]'
while read LINE; do
  case "$LINE" in
    y*) break ;;
    n*) exit 1 ;;
  esac
done

if ! brew -v > /dev/null; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# ディレクトリ名を英語化する
dirs=(~/Desktop ~/Documents ~/Downloads ~/Library ~/Library/Favorites ~/Movies ~/Music ~/Pictures ~/Public /Applications)
for d in ${dirs[@]}
do
	pushd $d > /dev/null
	[ -e .localized ] && [ ! -e .localized.disable ] && mv .localized .localized.disable
  popd > /dev/null
done


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




brew update
brew tap homebrew/versions
brew tap homebrew/dupes

brew install vim --with-lua --with-perl
brew install macvim --with-luajit
brew install sl

apps=(
  python3
  clang-format
  colordiff
  cowsay
  ctags
  direnv
  docker-compose
  gauche
  ghq
  git
  gnu-sed
  gnutls
  gperftools
  graphviz
  jo
  jq
  neovim/neovim/neovim
  nkf
  nmap
  peco
  reattach-to-user-namespace
  rlwrap
  sl
  terminal-notifier
  the_silver_searcher
  tig
  tmux
  tree
  w3m
  watch
  wget
  zsh
  zsh-completions
  zsh-syntax-highlighting
)

for app in ${apps[@]}
do
  brew install $app
done

casks=(
  alfred
  appcleaner
  atom
  gimp
  google-chrome
  google-japanese-ime
  iterm2
  keyboardcleantool
  menumeters
  sublime-text
  virtualbox
  xquartz
  java
  hammerspoon
)

for cask in ${casks[@]}
do
  brew cask install $cask
done

brew cask alfred link

