# complement
autoload -U compinit
autoload -Uz add-zsh-hook
compinit
export LANG=ja_JP.UTF-8

setopt auto_cd
setopt auto_pushd # 自動でディレクトリスタックに追加
setopt pushd_ignore_dups # ディレクトリスタックに同じディレクトリを追加しない
setopt nolistbeep # 曖昧補完でビープしない
setopt no_clobber # 上書きリダイレクトの禁止
setopt list_types # 補完時にファイルの種別を表示

export EDITOR=vim
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

function exists() {
  which $1 > /dev/null
}

if [[ -f /Applications/MacVim.app/Contents/MacOS/Vim ]]; then
  alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
fi

alias ls="ls -F"
alias mv='mv -i'
alias cp='cp -i'
alias quit='exit'
alias diff='diff --strip-trailing-cr'
alias evim='vim ~/.vimrc'
alias ezsh='vim ~/.zshrc'

alias ~='cd ~'
alias ..='cd ..'
alias ...='cd ...'
alias ....='cd ....'
alias -g ...='../../'
alias -g ....='../../../'
alias -g .....='../../../../'
alias a='a.out'
alias ls='ls -FG'
alias la='ls -alF'
alias ll='ls -l'
alias -g G='| grep -i'
alias -g V='| grep -v'
alias server='python -m SimpleHTTPServer'
alias jsx-debug='jsx --executable web --warn all --enable-type-check --enable-source-map'
alias jsx-release='jsx --executable web --release --optimize lto,unclassify,fold-const,return-if,inline,dce,unbox,fold-const,dce,lcse,array-length,unclassify'


function pb {
  cat $@ | pbcopy
}

function precmd() {
  if exists _z; then
    _z --add "$(pwd -P)"
  fi
}

counter=0
export counter
function _precmd_term_title () {
  if [[ 0 -eq `expr $counter % 7` ]]; then
      echo -n "\033]0;Let's＼(・ω・)／にゃー！\07"
  else
    if [[ 0 -eq `expr $counter % 7 % 2` ]]; then
      echo -n "\033]0;(／・ω・)／にゃー！    \07"
    else
      echo -n "\033]0;(」・ω・)」うー！      \07"
    fi
  fi
  counter=`expr $counter + 1`
}
# add-zsh-hook precmd _precmd_term_title

# keybinds
# ----------------------------------------
bindkey -e
bindkey '^[[1~' beginning-of-line # Home
bindkey '^[[4~' end-of-line # End
bindkey '^T' kill-word
bindkey '^U' backward-kill-line
bindkey '^[[3~' delete-char-or-list # Del
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

# about prompt
#----------------------------------------
# colorful : PROMPT='%{'$'\e[''$[32+$RANDOM % 5]m%}%U%B%m{%n}%b%{'$'\e[''m%}%U%%%u '
# PROMPT=$BLUE'${USER}@${HOSTNAME} '$GREEN'%~ '$'\n'$DEFAULT'%(!.#.$) '
# PROMPT="%B%{${fg[blue]}%}%n@%{${fg[blue]}%}%m:%{${fg[green]}%}%~"$'\n'"%b%{${fg[white]}%}%(!.#.$) "

TERM=xterm-256color
autoload colors
colors


setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '%s' '%b' '%i' '%c' '%u'
zstyle ':vcs_info:*' actionformats '%s' '%b' '%i' '%a' '%f'
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' max-exports 5


function _git_info() {
  # echo -n $vcs_info_msg_0_':'$vcs_info_msg_1_':'$vcs_info_msg_2_':'$vcs_info_msg_3_':'$vcs_info_msg_4_
  LANG=en_US.UTF-8 vcs_info
  if [[ $vcs_info_msg_0_ = 'git' ]]; then
    echo -n ' '
    STATUS=$(git status --porcelain 2> /dev/null)
    info=''
    if $(echo "$STATUS" | grep '^?? ' &> /dev/null); then
      info=$info'+'
    fi
    if $(echo "$STATUS" | grep '^A  ' &> /dev/null); then
      info=$info'A'
    elif $(echo "$STATUS" | grep '^M  ' &> /dev/null); then
      info=$info'A'
    fi
    if $(echo "$STATUS" | grep '^ M ' &> /dev/null); then
      info=$info'C'
    elif $(echo "$STATUS" | grep '^AM ' &> /dev/null); then
      info=$info'C'
    elif $(echo "$STATUS" | grep '^ T ' &> /dev/null); then
      info=$info'C'
    fi
    if $(echo "$STATUS" | grep '^R  ' &> /dev/null); then
      info=$info'R'
    fi
    if $(echo "$STATUS" | grep '^ D ' &> /dev/null); then
      info=$info'D'
    elif $(echo "$STATUS" | grep '^AD ' &> /dev/null); then
      info=$info'D'
    fi
    if $(echo "$STATUS" | grep '^UU ' &> /dev/null); then
      info=$info'%F{1}!'
    fi

    branch=''
    if $(echo "$info" | grep '!' &> /dev/null); then
      branch='%F{1}'
    elif $(echo "$info" | grep '[+ACRD]' &> /dev/null); then
      branch='%F{3}'
    else
      branch='%F{2}'
    fi

    echo -n $vcs_info_msg_0_':('$branch$vcs_info_msg_1_'%f):'$info'%f'
  elif [[ $vcs_info_msg_0_ = 'svn' ]]; then
    echo -n ' '
    echo -n $vcs_info_msg_0_':('$vcs_info_msg_1_')'
  fi
}

function _opt_info() {
}

# RPROMPT="%S%D{%Y/%m/%d} %*%s"
PROMPT="%{$reset_color%}%B%{${fg[blue]}%}%n@%{${fg[blue]}%}%m:%{${fg[green]}%}%~%{$reset_color%}\$(_git_info)"$'\n'"%b%{$reset_color%}%(!.#.$) "

# ls color
#----------------------------------------
export LS_COLORS='so=33:bd=44;37:cd=44;37:ex=35:or=41'
# export LSCOLORS=hxdxgxcxbxegedabagacad
export LSCOLORS=hxfxcxdxbxegedabagacad



# history settings
#----------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history
setopt hist_reduce_blanks

# personal
#----------------------------------------
alias javac='javac -J-Dfile.encoding=UTF-8'
alias java='java -Dfile.encoding=UTF-8'
export PATH=/usr/local/bin:$PATH
export PATH=/Applications/android-sdk/platform-tools:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$HOME/.rbenv/bin:$PATH

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig


if exists nodebrew; then
  nodebrew use v0.8.8
else
  echo "nodebrew is not installed"
fi


if exists rbenv; then
  eval "$(rbenv init -)"
else
  echo "rbenv in not installed"
fi

if exists brew; then
  zpath=`brew --prefix`/etc/profile.d/z.sh
  if [[ -f $zpath ]]; then
    _Z_CMD=j
    . $zpath
  fi
fi



# color debug

typeset -Ag FX FG BG

FX=(
    reset     "%{[00m%}"
    bold      "%{[01m%}" no-bold      "%{[22m%}"
    italic    "%{[03m%}" no-italic    "%{[23m%}"
    underline "%{[04m%}" no-underline "%{[24m%}"
    blink     "%{[05m%}" no-blink     "%{[25m%}"
    reverse   "%{[07m%}" no-reverse   "%{[27m%}"
)

for color in {000..255}; do
    FG[$color]="%{[38;5;${color}m%}"
    BG[$color]="%{[48;5;${color}m%}"
done

# Show all 256 colors with color number
function spectrum_ls() {
  for code in {000..255}; do
    print -P -- "$code: %F{$code}Test%f"
  done
}

function spectrumlist() {
  ruby -e '255.times {|i| print i.to_s.rjust(5)+" " if i>=16;print "\033[48;5;#{i}m \033[0m"; puts if i>=10 && i<232 && (i-10)%6==5 }'
}

function spectrums() {
  ruby -e '255.times {|i| print "\033[48;5;#{i}m \033[0m"; puts if i>=10 && i<232 && (i-10)%6==5 }'
}

function g() {
  grep -r "$1" .
}

function gg() {
  grep -rl "$1" .
}

export RSENSE_HOME=$HOME/.vim/bundle/rsense

if [[ -f ~/.zshrc_local ]]; then
  source ~/.zshrc_local
fi

