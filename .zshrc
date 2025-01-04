# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Autoloads

autoload -Uz compinit     # compinitの読み込み
autoload -Uz add-zsh-hook # zshのフック関数を使うための準備
compinit                  # 補完機能を有効化
autoload -Uz colors       # $fg[red] や $bg[blue]を使うための準備
colors                    # 色の設定を有効化
autoload -Uz vcs_info     # vcs_infoの読み込み


function exists() {
  hash $1 > /dev/null 2>&1
}


fpath=(/usr/local/share/zsh-completions $fpath)
if [ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi



# Options

setopt auto_cd              # コマンドがディレクトリ名だった場合cdする
setopt auto_pushd           # 自動でディレクトリスタックに追加
setopt pushd_ignore_dups    # ディレクトリスタックに同じディレクトリを追加しない
setopt nolistbeep           # 曖昧補完でビープしない
setopt no_clobber           # 上書きリダイレクトの禁止(>! や >| で上書き可)
setopt list_types           # 補完時にファイルの種別を表示
setopt prompt_subst         # prompt文字列(PS1など)でのコマンドとか算術を有効化する

zstyle ':completion:*' ignore-parents parent pwd ..  # 今いるディレクトリを cd ../ の補完候補から外す

export REPORTTIME=3

disable r # 直前のコマンドを再実行する r コマンドを無効化



# History

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt hist_ignore_all_dups # 履歴のどこかに 同じコマンドが存在すると、それを削除してから末尾に追加する
setopt share_history        # ターミナル間でのコマンド履歴共有
setopt hist_reduce_blanks



# Exports

export LANG=ja_JP.UTF-8

eval "$(/opt/homebrew/bin/brew shellenv)"



# PATH

path=(
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  $HOME/bin(N-/)
  $path
)
if exists brew; then
  export HOMEBREW_ROOT=`brew --prefix`
  path=(
    $HOMEBREW_ROOT/opt/gnu-sed/libexec/gnubin(N-/)
    $HOMEBREW_ROOT/opt/openssl@1.1/bin(N-/)
    $HOMEBREW_ROOT/opt/mysql-client/bin(N-/)
    $HOMEBREW_ROOT/opt/libpq/bin(N-/)
    ~/.cabal/bin(N-/)
    $path
  )
fi
export MANPATH=$HOMEBREW_ROOT/opt/gnu-sed/libexec/gnuman:$MANPATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
export RSENSE_HOME=/usr/local/Cellar/rsense/0.3/libexec
export XDG_CONFIG_HOME=$HOME/.config



export EDITOR=vim
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# Override default command
alias ls='ls -G'                                             # Show [/*@], Enable color
alias mv='mv -i'                                             # Comfirm overwrite
alias cp='cp -i'                                             # Comfirm overwrite
alias diff='diff --strip-trailing-cr'
alias less='less -R'                                         # Color escape sequences will displayed

# Useful aliases
alias sushi="ruby -e 'C=\`stty size\`.scan(/\d+/)[1].to_i;S=\"\xf0\x9f\x8d\xa3\";a={};puts \"\033[2J\";loop{a[rand(C)]=0;a.each{|x,o|;a[x]+=1;print \"\033[#{o};#{x}H \033[#{a[x]};#{x}H#{S} \033[0;0H\"};\$stdout.flush;sleep 0.01}'"
alias perldoc='perldoc -MPod::Perldoc::Cache -w parser=Pod::Text::Color::Delight'


alias -g ...='../../'
alias -g ....='../../../'
alias -g .....='../../../../'
alias -g ......='../../../../../'
alias -g G='| grep -i'
alias -g V='| grep -v'


alias evim='vim ~/.vimrc'
alias ezsh='vim ~/.zshrc'
alias la='ls -alF'
alias ll='ls -l'

alias server='python3 -m http.server'
alias res='echo $?'
alias tmux="tmux -2"
alias pboard='echo "do not use pboard"'



function match() {
  echo $1 | grep $2 &> /dev/null
}


# Keybinds

bindkey -e
bindkey '^[[1~' beginning-of-line # Home
bindkey '^[[4~' end-of-line # End
bindkey '^T' kill-word
bindkey '^U' backward-kill-line
bindkey '^[[3~' delete-char-or-list # Del
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward



# Environment managers

if exists brew; then
  zpath=`brew --prefix`/etc/profile.d/z.sh
  if [[ -f $zpath ]]; then
    _Z_CMD=j
    . $zpath
  fi
fi

if exists asdf; then
  . ~/.asdf/plugins/java/set-java-home.zsh
  . ~/.asdf/plugins/golang/set-env.zsh
fi


function cl() {
  yes '' | head -n 1000
  clear
}

function q() {
  local selected_dir=$(ghq list -p | sort | sed "s#$HOME/src/##" | grep -v '/old/' | peco --query "$LBUFFER")
  if [ -z "$selected_dir" ]; then
    return
  fi

  session=`echo ${selected_dir} | sed -e 's/\./_/g'`

  if tmux ls | awk -F: '{print $1}' | grep "^${session}$"; then
    if [ -n "$TMUX" ]; then
      tmux switch -t $session
    else
      tmux attach -t $session
    fi
  else
    cd "${HOME}/src/${selected_dir}"
    tmux new-session -d -s $session
    if [ -n "$TMUX" ]; then
      tmux switch -t $session
    else
      tmux attach -t $session
    fi
  fi
}

### Heroku
export PATH="/usr/local/heroku/bin:$PATH"

### ImageMagick
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"

### asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

### p10k
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if exists direnv; then
  eval "$(direnv hook zsh)"
fi

### gcloud
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

### rye
source "$HOME/.rye/env"

### pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
