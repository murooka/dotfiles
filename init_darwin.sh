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
  echo 'install homebrew'
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# ディレクトリ名を英語化する
dirs=(~/Desktop ~/Documents ~/Downloads ~/Library ~/Library/Favorites ~/Movies ~/Music ~/Pictures ~/Public /Applications ~/Applications)
for d in ${dirs[@]}
do
	pushd $d > /dev/null
	[ -e .localized ] && [ ! -e .localized.disable ] && mv .localized .localized.disable
  popd > /dev/null
done

mkdir -p ~/.vim_backup
mkdir -p ~/bin
mkdir -p ~/.config
mkdir -p "$XDG_CONFIG_HOME/git"

# 設定ファイル類の準備
DOT_FILES=(.gemrc .gitconfig .gvimrc .irbrc .tmux.conf .vim .vimrc .vrapperrc .zshrc .my.cnf .emacs.d)
for file in "${DOT_FILES[@]}"
do
    [ ! -e "$HOME/$file" ] && ln -s "$HOME/dotfiles/$file" "$HOME"
done

[ ! -e "$XDG_CONFIG_HOME/git/ignore" ] && ln -s "$HOME/dotfiles/ignore" "$XDG_CONFIG_HOME/git/ignore"

[ ! -e "$HOME/.config/nvim" ] && ln -s "$HOME/dotfiles/.vim" "$HOME/.config/nvim"


git submodule init
git submodule update




brew update

brew install vim
brew install yarn --ignore-dependencies

apps=(
  asdf
  bat
  clang-format
  colordiff
  ctags
  direnv
  exa
  ghq
  git
  gnu-sed
  gnutls
  go
  graphviz
  jq
  mkcert
  nkf
  nmap
  peco
  python3
  reattach-to-user-namespace
  rlwrap
  shellcheck
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
  anyenv
)

for app in ${apps[@]}
do
  brew install $app
done

# google-chrome
# virtualbox
casks=(
  alfred
  appcleaner
  google-japanese-ime
  iterm2
  karabiner-elements
  keyboardcleantool
  virtualbox
  visual-studio-code
)

for cask in ${casks[@]}
do
  brew cask install $cask
done

go get -u github.com/motemen/ghq
