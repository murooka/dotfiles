# complement
autoload -U compinit
compinit
export LANG=ja_JP.UTF-8
setopt prompt_subst

setopt auto_cd
setopt auto_pushd # 自動でディレクトリスタックに追加
setopt pushd_ignore_dups # ディレクトリスタックに同じディレクトリを追加しない
setopt correct
setopt nolistbeep # 曖昧補完でビープしない
setopt no_clobber # 上書きリダイレクトの禁止
setopt list_types # 補完時にファイルの種別を表示

export EDITOR=vim
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

alias ls="ls -F"
alias mv='mv -i'
alias cp='cp -i'
alias quit='exit'

alias ~='cd ~'
alias ..='cd ..'
alias ...='cd ...'
alias ....='cd ....'
alias -g ...='../../'
alias -g ....='../../../'
alias -g .....='../../../../'
alias a='a.out'
alias ls='ls -GF'
alias la='ls -alF'
alias ll='ls -l'
alias -g G='| grep -i'


function cd { 
builtin cd $@
if [ 21 -ge $(ls|wc|awk '{print $1}') ]; then
  ls
fi
}


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
bindkey '^B' backward-word

# about prompt
#----------------------------------------
TERM=xterm-256color
# colorful
# PROMPT='%{'$'\e[''$[32+$RANDOM % 5]m%}%U%B%m{%n}%b%{'$'\e[''m%}%U%%%u '
autoload promptinit
promptinit
autoload colors
colors
local GREEN=$'%{\e[1;32m%}'
local YELLOW=$'%{\e[1;33m%}'
local BLUE=$'%{\e[1;34m%}'
local DEFAULT=$'%{\e[1;m%}'
PROMPT=$BLUE'${USER}@${HOSTNAME} '$GREEN'%~ '$'\n'$DEFAULT'%(!.#.$) '
PROMPT="%{${fg[red]}%}%n@%{${fg[red]}%}%m:%{${fg[yellow]}%}%~"$'\n'"%{${fg[white]}%}%(!.#.$) "
RPROMPT="%S%D{%Y/%m/%d} %*%s"


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
export PATH=/Users/CHARLIE/scala-2.8.0.final/bin:$PATH
export PATH=/Users/CHARLIE/CompArch/carch/bin:$PATH
export PATH=/Users/CHARLIE/CompArch/work:$PATH
export PATH=/opt/local/bin/:/opt/local/sbin:$PATH
export PATH=/opt/bin:$PATH
export PATH=/Users/CHARLIE/Library/lmntal/bin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export MANPATH=/opt/local/man:$MANPATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
# java path
export JUNIT_HOME=/usr/local/java
export SCALA_HOME=/usr/local/Cellar/scala/2.9.1
export CLASSPATH=$JUNIT_HOME/junit.jar:$CLASSPATH
export CLASSPATH=$SCALA_HOME/libexec/lib/scala-library.jar:$CLASSPATH
export CLASSPATH=$SCALA_HOME/libexec/lib/scala-swing.jar:$CLASSPATH
export CLASSPATH=/Users/CHARLIE/Dropbox/Programming/JavaPackage/bin/mrlib.jar:$CLASSPATH
export LMNTAL_HOME=/Users/CHARLIE/LMNtal/devel
export PKG_CONFIG_PATH=/Users/CHARLIE/OpenCV/lib/pkgconfig:$PKG_CONFIG_PATH


[[ -s "/Users/charlie/.rvm/scripts/rvm" ]] && source "/Users/charlie/.rvm/scripts/rvm"

# rvm setting
rvm 1.9.2
rvm gemset use rails310




