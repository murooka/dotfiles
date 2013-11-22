# Autoloads {{{

autoload -Uz compinit
autoload -Uz add-zsh-hook
compinit
autoload -Uz colors
colors
autoload -Uz vcs_info

# }}}


fpath=(/usr/local/share/zsh-completions $fpath)
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# Options {{{

setopt auto_cd           # コマンドがディレクトリ名だった場合cdする
setopt auto_pushd        # 自動でディレクトリスタックに追加
setopt pushd_ignore_dups # ディレクトリスタックに同じディレクトリを追加しない
setopt nolistbeep        # 曖昧補完でビープしない
setopt no_clobber        # 上書きリダイレクトの禁止
setopt list_types        # 補完時にファイルの種別を表示
setopt prompt_subst      # prompt文字列でのコマンドとか算術を有効化する

zstyle ':completion:*' ignore-parents parent pwd ..  # 今いるディレクトリを cd ../ の補完候補から外す

REPORTTIME=3

disable r

# }}}


# History {{{

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history
setopt hist_reduce_blanks

# }}}


# Exports {{{

export LANG=ja_JP.UTF-8

# PATH {{{
# TODO: homebrewが入ってない環境に対応する
export HOMEBREW_ROOT=`brew --prefix`
export PATH=/usr/local/bin:$PATH
export PATH=/Applications/android-sdk/platform-tools:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$HOME/.rbenv/bin:$PATH
export PATH=$HOME/.cabal/bin:$PATH
export PATH=$HOMEBREW_ROOT/opt/gnu-sed/libexec/gnubin:$PATH
export MANPATH=$HOMEBREW_ROOT/opt/gnu-sed/libexec/gnuman:$MANPATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
export RSENSE_HOME=/usr/local/Cellar/rsense/0.3/libexec
export GOROOT=/usr/local/Cellar/go/1.1.2/libexec
export GOPATH=~/.go
# }}}

export EDITOR=vim
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>'
# export LS_COLORS='so=33:bd=44;37:cd=44;37:ex=35:or=41'     # GNU ls color
export LSCOLORS=gxfxcxdxbxegedabagacad                       # BSD ls color
export SBT_OPTS=-XX:MaxPermSize=4g
export PERL_RL=EditLine

# }}}


# Useful aliases {{{

# Override default command {{{
alias ls='ls -FG'                                            # Show [/*@], Enable color
alias mv='mv -i'                                             # Comfirm overwrite
alias cp='cp -i'                                             # Comfirm overwrite
alias diff='diff --strip-trailing-cr'
alias less='less -R'                                         # Color escape sequences will displayed

alias perldoc='perldoc -M Pod::Text::Color::Delight'
alias javac='javac -J-Dfile.encoding=UTF-8'
alias java='java -Dfile.encoding=UTF-8'
# }}}


alias -g ...='../../'
alias -g ....='../../../'
alias -g .....='../../../../'
alias -g ......='../../../../../'
alias -g G='| grep -i'
alias -g V='| grep -v'
alias -g L='| less'


alias quit='exit'
alias evim='vim ~/.vimrc'
alias ezsh='vim ~/.zshrc'
alias la='ls -alF'
alias ll='ls -l'

alias server='python -m SimpleHTTPServer'
alias jsx-debug='jsx --executable web --warn all --enable-type-check --enable-source-map'
alias jsx-release='jsx --executable web --release --optimize lto,unclassify,fold-const,return-if,inline,dce,unbox,fold-const,dce,lcse,array-length,unclassify'
alias lavit='java -Dawt.useSystemAAFontSettings=lcd -jar LaViT.jar'
alias res='echo $?'
alias git-rank="history -E 1 | grep '  git' | awk '{print \$4,\$5,\$6}' | sort | uniq -c | sort -nr | less"
# }}}


function exists() {
  which $1 > /dev/null
}

function match() {
  echo $1 | grep $2 &> /dev/null
}

function pb {
  cat $@ | pbcopy
}

function precmd() {
  if exists _z; then
    _z --add "$(pwd -P)"
  fi
}

counter=1
export counter
function _precmd_term_title () {
  if [[ 0 -eq $(( $counter % 7 )) ]]; then
      echo -n "\033]0;Let's＼(・ω・)／にゃー！\07"
  elif [[ 0 -eq `expr $counter % 7 % 2` ]]; then
    echo -n "\033]0;(／・ω・)／にゃー！    \07"
  else
    echo -n "\033]0;(」・ω・)」うー！      \07"
  fi
  counter=$(($counter + 1))
}
add-zsh-hook precmd _precmd_term_title

# Keybinds {{{

bindkey -e
bindkey '^[[1~' beginning-of-line # Home
bindkey '^[[4~' end-of-line # End
bindkey '^T' kill-word
bindkey '^U' backward-kill-line
bindkey '^[[3~' delete-char-or-list # Del
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

# }}}

# Prompt {{{

zstyle ':vcs_info:*' enable git cvs svn hg                            # Enable only these VCSs
zstyle ':vcs_info:*' formats '%s' '%b' '%i'                           # Formats are "VCS" "Branch" "Revision"
zstyle ':vcs_info:*' actionformats '%s' '%b' '%i' '%a'                # Action formats are "VCS" "Branch" "Revision" "Action" ""
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' max-exports 4

function _git_info() { # {{{
  local vcs branch action STATUS

  vcs=$vcs_info_msg_0_
  branch=$vcs_info_msg_1_
  action=$vcs_info_msg_3_
  STATUS=`git status --porcelain 2> /dev/null`

  info=''
  if match $STATUS '^?? '            ; then info=$info'+' fi
  if match $STATUS '^\(A\|M\)  '     ; then info=$info'A' fi
  if match $STATUS '^\( M\|AM\| T\) '; then info=$info'C' fi
  if match $STATUS '^R  '            ; then info=$info'R' fi
  if match $STATUS '^\( D\|AD\) '    ; then info=$info'D' fi
  if match $STATUS '^UU '            ; then info=$info'!' fi

  if [[ $action = 'rebase' ]]; then
    branch="rebasing $branch"
  elif [[ $action = 'merge' ]]; then
    ## Merge相手のブランチ名を取得
    their=$(cat `git rev-parse --show-toplevel`/.git/MERGE_MSG | head -1 | sed -e "s/Merge branch '\(.*\)'/\1/")
    branch="merging $branch and $their"
  fi

  if match $info '!'; then
    branch="%F{1}$branch%f"
    info="%F{1}$info%f"
  elif match $info '[+ACRD]'; then
    branch="%F{3}$branch%f"
  else
    branch="%F{2}$branch%f"
  fi

  echo -n " $vcs:($branch):$info"
} # }}}

function _vcs_info() {
  LANG=en_US.UTF-8 vcs_info
  # echo -n $vcs_info_msg_0_':'$vcs_info_msg_1_':'$vcs_info_msg_2_':'$vcs_info_msg_3_':'$vcs_info_msg_4_ # debug
  if [[ $vcs_info_msg_0_ = 'git' ]]; then
    _git_info
  elif [[ $vcs_info_msg_0_ = 'svn' ]]; then
    echo -n ' '$vcs_info_msg_0_':('$vcs_info_msg_1_')'
  fi
}

PROMPT="%{$reset_color%}%B%{${fg[blue]}%}%n@%{${fg[blue]}%}%m:%{${fg[green]}%}%~%{$reset_color%}\$(_vcs_info)"$'\n'"%b%{$reset_color%}%(!.#.$) "

() {
  # vimから:shellでzshを開いた時にわかりやすくする

  local pp cmd
  pp=`ps -o "pid ppid" | awk '{print $1, $2}' | grep "^$$" | cut -d ' ' -f 2`       # 自分の親プロセスのpid
  cmd=`ps -o "pid command" | awk '{print $1, $2}' | grep "^$pp" | cut -d ' ' -f 2`  # 自分の親プロセスのcommand
  if [[ $cmd = 'vim' ]]; then
    PROMPT="%{${fg[blue]}${bg[white]}%}%B[vim]%b%{${reset_color}%} $PROMPT"
  fi
}

# }}}


# Environment managers {{{

if exists nodebrew; then
  nodebrew use latest > /dev/null
  echo -n 'node '
  node -v
fi

if exists rbenv; then
  eval "$(rbenv init -)"
  echo -n 'ruby '
  rbenv version
fi

if exists perlbrew; then
  source ~/perl5/perlbrew/etc/bashrc
  echo "$PERLBREW_PERL"
fi

if exists brew; then
  zpath=`brew --prefix`/etc/profile.d/z.sh
  if [[ -f $zpath ]]; then
    _Z_CMD=j
    . $zpath
  fi
fi

# }}}


function g() {
  grep -r "$1" .
}

function gg() {
  grep -rl "$1" .
}

function graphvizall() {
  for cmd in dot neato fdp sfdp twopi circo; do
    file=`echo $1 | sed -e 's/\.dot$//g'`
    $cmd -Tpng -o $file.$cmd.png $1
  done
}

if [[ -f ~/.zshrc_local ]]; then
  source ~/.zshrc_local
fi


