# Autoloads {{{

autoload -Uz compinit
autoload -Uz add-zsh-hook
compinit
autoload -Uz colors
colors
autoload -Uz vcs_info

# }}}


function exists() {
  hash $1 > /dev/null 2>&1
}


fpath=(/usr/local/share/zsh-completions $fpath)
if [ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi


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


function match() {
  echo $1 | grep $2 &> /dev/null
}


# History {{{

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history
setopt hist_reduce_blanks

# }}}


# Exports {{{

export LANG=ja_JP.UTF-8

# PATH {{{
export GOPATH=$HOME
export GOROOT=/usr/local/go

# TODO: homebrewが入ってない環境に対応する
path=(
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  $HOME/bin(N-/)
  $HOME/.cabal/bin(N-/)
  $HOME/go_appengine(N-/)
  $HOME/flutter/bin(N-/)
  $GOROOT/bin(N-/)
  $JAVA_HOME/bin(N-/)
  /Applications/android-sdk/platform-tools(N-/)
  /Applications/android-sdk/tools(N-/)
  $path
)
if exists brew; then
  export HOMEBREW_ROOT=`brew --prefix`
  path=(
    $HOMEBREW_ROOT/opt/gnu-sed/libexec/gnubin(N-/)
    $HOMEBREW_ROOT/opt/openssl@1.1/bin(N-/)
    $GOROOT/bin(N-/)
    ~/.cabal/bin(N-/)
    $path
  )
fi
export MANPATH=$HOMEBREW_ROOT/opt/gnu-sed/libexec/gnuman:$MANPATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
export RSENSE_HOME=/usr/local/Cellar/rsense/0.3/libexec
export XDG_CONFIG_HOME=$HOME/.config
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
alias ls='ls -G'                                             # Show [/*@], Enable color
alias mv='mv -i'                                             # Comfirm overwrite
alias cp='cp -i'                                             # Comfirm overwrite
alias diff='diff --strip-trailing-cr'
alias less='less -R'                                         # Color escape sequences will displayed
alias sushi="ruby -e 'C=\`stty size\`.scan(/\d+/)[1].to_i;S=\"\xf0\x9f\x8d\xa3\";a={};puts \"\033[2J\";loop{a[rand(C)]=0;a.each{|x,o|;a[x]+=1;print \"\033[#{o};#{x}H \033[#{a[x]};#{x}H#{S} \033[0;0H\"};\$stdout.flush;sleep 0.01}'"

alias perldoc='perldoc -MPod::Perldoc::Cache -w parser=Pod::Text::Color::Delight'
# }}}


alias -g ...='../../'
alias -g ....='../../../'
alias -g .....='../../../../'
alias -g ......='../../../../../'
alias -g G='| grep -i'
alias -g V='| grep -v'
alias -g L='| less'
alias -g N='2>/dev/null'


alias quit='exit'
alias evim='vim ~/.vimrc'
alias ezsh='vim ~/.zshrc'
alias la='ls -alF'
alias ll='ls -l'

alias server='python3 -m http.server'
alias jsx-debug='jsx --executable web --warn all --enable-type-check --enable-source-map'
alias jsx-release='jsx --executable web --release --optimize lto,unclassify,fold-const,return-if,inline,dce,unbox,fold-const,dce,lcse,array-length,unclassify'
alias res='echo $?'
alias git-rank="history -E 1 | grep '  git' | awk '{print \$4,\$5,\$6}' | sort | uniq -c | sort -nr | less"
alias reply="rlwrap reply"
alias tmux="tmux -2"
alias pboard='echo "do not use pboard"'
alias dc='docker-compose'
alias vscode='open -a /Applications/Visual\ Studio\ Code.app'
# }}}


function match() {
  echo $1 | grep $2 &> /dev/null
}

function precmd() {
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
  STATUS=`git status --ignore-submodules --porcelain 2> /dev/null`

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

  echo -n " $vcs:$action:($branch):$info"
} # }}}

export _VCS_BRANCH_ENABLED=1
function enable_vcs_branch() {
  export _VCS_BRANCH_ENABLED=1
}

function disable_vcs_branch() {
  unset _VCS_BRANCH_ENABLED
}

function _vcs_info() {
  if [ $_VCS_BRANCH_ENABLED ]; then
    LANG=en_US.UTF-8 vcs_info
    # echo -n $vcs_info_msg_0_':'$vcs_info_msg_1_':'$vcs_info_msg_2_':'$vcs_info_msg_3_':'$vcs_info_msg_4_ # debug
    if [[ $vcs_info_msg_0_ = 'git' ]]; then
      _git_info
    elif [[ $vcs_info_msg_0_ = 'svn' ]]; then
      echo -n ' '$vcs_info_msg_0_':('$vcs_info_msg_1_')'
    fi
  fi
}

PROMPT="%{$reset_color%}%B%{${fg[blue]}%}%n@%{${fg[blue]}%}%m:%{${fg[green]}%}%~%{$reset_color%}\$(_vcs_info)"$'\n'"%b%{$reset_color%}%(!.#.$) "
# PROMPT="%{$reset_color%}%B%{${fg[blue]}%}%n@%{${fg[blue]}%}%m:%{${fg[green]}%}%~%{$reset_color%}\$(_vcs_info)"$'\n'"%b%{$reset_color%}%{${fg[green]}%}%(!.#.﷽       )%{$reset_color%} "

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

if exists brew; then
  zpath=`brew --prefix`/etc/profile.d/z.sh
  if [[ -f $zpath ]]; then
    _Z_CMD=j
    . $zpath
  fi
fi

if exists direnv; then
  eval "$(direnv hook zsh)"
fi

# }}}


function graphvizall() {
  for cmd in dot neato fdp sfdp twopi circo; do
    file=`echo $1 | sed -e 's/\.dot$//g'`
    $cmd -Tpng -o $file.$cmd.png $1
  done
}

function pprove() {
  file=`find $1 -name "*.t" | peco`
  echo "prove $file"
  prove $file
}

if [[ -f ~/.zshrc_local ]]; then
  source ~/.zshrc_local
fi


export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[02;32m'


function _longtime_preexec {
  # マッチするコマンドの時は無視する
  [[ $2 == (sc|screen|tmux|ssh|vim|git|tig|perldoc ci)\ * ]] && return

  _longtime_time=`date +%s`
  _longtime_cmd=$2
}

function _longtime_precmd {
  [ ${+_longtime_time} = 1 ] || return

  local time=$((`date +%s` - $_longtime_time))

  if [ $time -gt 10 ]
  then
    terminal-notifier -title 'done' -message "$_longtime_cmd"

    local unit=sec
    if [ $time -gt 120 ]
    then
      time=$(( $time / 60 ))
      unit=min
    fi
    echo took $time $unit
  fi

  unset _longtime_time
  unset _longtime_cmd
}

add-zsh-hook preexec _longtime_preexec
add-zsh-hook precmd _longtime_precmd

findconfig() {
  if [ -f "$1" ]; then
    printf '%s\n' "${PWD%/}/$1"
  elif [ "$PWD" = / ]; then
    false
  else
    (cd .. && findconfig "$1")
  fi
}

function _echo_preexec {
  local CONFIG=$(findconfig '.localhistoryrc')
  if [ -n "$CONFIG" ]; then
    local HISTORY="${CONFIG/.localhistoryrc/.localhistory}"
    touch "$HISTORY"
    echo "$(date '+%Y-%m-%d %H:%M:%S') $1" >> "$HISTORY"
  fi
}

add-zsh-hook preexec _echo_preexec


# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT=/Users/naoki.yaguchi/Work/cocos2d-x/tools/cocos2d-console/bin
export PATH=$COCOS_CONSOLE_ROOT:$PATH

function arc() {
  clang++ -std=c++11 -o $1 $1.cc
  ./$1
}

function abc() {
  cat $1.cc | pbcopy
}

function cl() {
  yes '' | head -n 1000
  clear
}

function q() {
  local selected_dir=$(ghq list -p | sort | sed "s#$HOME/src/##" | peco --query "$LBUFFER")
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

if [[ -f $HOME/.zaw/zaw.zsh ]]; then
  source $HOME/.zaw/zaw.zsh
fi

zstyle ':filter-select:highlight' selected fg=black,bg=white,standout
zstyle ':filter-select' case-insensitive yes

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

if exists direnv; then
  eval "$(direnv hook zsh)"
fi
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/n-yaguchi/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/n-yaguchi/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/n-yaguchi/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/n-yaguchi/google-cloud-sdk/completion.zsh.inc'; fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/n-yaguchi/.sdkman"
[[ -s "/Users/n-yaguchi/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/n-yaguchi/.sdkman/bin/sdkman-init.sh"

. /usr/local/opt/asdf/asdf.sh
