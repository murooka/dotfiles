#!/bin/sh

dirs=(
	~/Desktop
	~/Documents
	~/Downloads
	~/Library
	~/Library/Favorites
	~/Movies
	~/Music
	~/Pictures
	~/Public
	/Applications
)
for d in ${dirs[@]}
do
	cd $d
	mv .localized .localized.disable
done



brew update
brew tap homebrew/versions
brew tap homebrew/dupes

brew install vim --with-lua --with-perl
brew install macvim --with-luajit
brew install sl

apps=(
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
  gradle
  graphviz
  jo
  jq
  matsu-chara/brew-bundle/brew-bundle
  maven
  neovim/neovim/neovim
  nkf
  nmap
  peco
  reattach-to-user-namespace
  rlwrap
  sbt
  scala
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
)

for cask in ${casks[@]}
do
  brew cask install $cask
done

brew cask alfred link
