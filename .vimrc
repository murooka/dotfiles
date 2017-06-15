scriptencoding utf-8

let $VIM_ROOT=$HOME.'/.vim'

"============================================================
" plugin settings
"============================================================

filetype off
filetype plugin indent off

if $GOROOT != ''
  set runtimepath+=$GOROOT/misc/vim/
endif

if 0 | endif

if has('vim_starting')
  set nocompatible
endif

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" if dein#check_install(['Shougo/vimproc.vim'])
"   call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
" endif

if dein#check_install()
  call dein#install()
endif

filetype on
filetype plugin indent on

let g:vim_json_syntax_conceal = 0

if dein#tap('unite.vim') "{{{

  let g:unite_no_default_keyappings = 1
  let g:unite_enable_start_insert = 1

  nnoremap <silent> <Space>uf :<C-u>Unite -buffer-name=files file file/new<CR>
  nnoremap <silent> <Space>un :<C-u>Unite file/new<CR>
  nnoremap <silent> <Space>ud :<C-u>Unite directory_mru<CR>
  nnoremap <silent> <Space>ub :<C-u>Unite buffer<CR>
  nnoremap <silent> <Space>ua :<C-u>Unite -buffer-name=history file_mru<CR>
  nnoremap <silent> <Space>us :<C-u>Unite snippet<CR>
  nnoremap <silent> <Space>um :<C-u>Unite mapping<CR>
  nnoremap <silent> <Space>ur :<C-u>Unite rails<CR>
  nnoremap <silent> <Space>uh :<C-u>Unite outline<CR>

  augroup UniteCmd
    autocmd! UniteCmd
    autocmd FileType unite call s:unite_my_settings()
  augroup END

  function! s:unite_my_settings()
    imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  endfunction

endif "}}}

if dein#tap('denite.nvim') "{{{
  call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
  call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
  call denite#custom#map('insert', '<C-a>', '<denite:move_caret_to_head>', 'noremap')
  call denite#custom#map('insert', '<C-k>', '<denite:delete_text_after_caret>', 'noremap')
  call denite#custom#map('insert', '<C-w>', '<denite:delete_word_before_caret>', 'noremap')

  nnoremap <silent> <Space>uf :<C-u>Denite file_rec<CR>
  nnoremap <silent> <Space>ub :<C-u>Denite buffer<CR>
endif "}}}

if dein#tap('deoplete.nvim') "{{{
  let g:deoplete#enable_at_startup = 1
endif "}}}

if dein#tap('neocomplete') "{{{

  let g:acp_enableAtStartup = 0
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#auto_completion_start_length = 3
  let g:neocomplete#min_keyword_length = 4
  let g:neocomplete#enable_ignore_case = 0
  let g:neocomplete#enable_auto_select = 1
  let g:neocomplete#enable_camel_case_completion = 0 " input AE -> suggest ArgumentsException
  let g:neocomplete#skip_auto_completion_time = '0.3'
  let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default'         : '',
        \ 'java'            : $VIM_ROOT.'/dict/java14.dict',
        \ 'scala'           : $VIM_ROOT.'/dict/scala.dict'
        \ }
  let g:neosnippet#snippets_directory = $VIM_ROOT.'/snippets'

  imap <C-j> <Plug>(neosnippet_expand_or_jump)
  smap <C-j> <Plug>(neosnippet_expand_or_jump)
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  nnoremap <silent> <Space>ns :NeoSnippetEdit<CR>
  inoremap <expr><C-n> pumvisible() ? "\<C-n>" : "\<C-x>\<C-o>\<Down>"
  inoremap <expr><C-k> "\<C-x>\<C-o>"

  " if !exists('g:neocomplete#sources#omni#input_patterns')
  "   let g:neocomplete#sources#omni#input_patterns = {}
  " endif
  "
  " if !exists('g:neocomplete#sources#omni#functions')
  "   let g:neocomplete#sources#omni#functions = {}
  " endif
  "
  " if !exists('g:neocomplete#force_omni_input_patterns')
  "   let g:neocomplete#force_omni_input_patterns = {}
  " endif


  " Clang complete {{{

  let $CLANG_ROOT = "/usr/local/clang_0522"

  let g:clang_exe = $CLANG_ROOT . "/bin/clang"
  let g:clang_complete_auto = 0
  let g:clang_auto_select = 0
  let g:clang_conceal_snippets = 1
  let g:clang_debug = 0
  let g:clang_use_library = 1
  let g:clang_library_path = $CLANG_ROOT . "/lib"
  " let g:neocomplete#force_omni_input_patterns.c =
  "       \ '[^.[:digit:] *\t]\%(\.\|->\)'
  " let g:neocomplete#force_omni_input_patterns.cpp =
  "       \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

  " }}}

  " Java complete {{{

  augroup JavaComplete
    autocmd! JavaComplete
    autocmd FileType java :setlocal omnifunc=javacomplete#Complete
    autocmd FileType java :setlocal completefunc=javacomplete#CompleteParamsInfo
  augroup END

  " let g:neocomplete#force_omni_input_patterns.java = 
  "       \ '[^. *\t]\.\h\w*\'

  " }}}

  " Rsense {{{

  " let g:neocomplete#sources#rsense#home_directory = '/usr/local/Cellar/rsense/0.3/libexec'
  " let g:neocomplete_omni_patterns.ruby = \ '[^. *\t]\.\w*\|\h\w*::'

  " }}}

endif "}}}

if dein#tap('vimproc') "{{{
  nnoremap <silent> <Space>vs :<C-u>VimShell<CR>
  nnoremap <silent> <Space>vr :<C-u>VimShellInteractive irb<CR>

endif "}}}

if dein#tap('caw.vim') "{{{

  silent! nmap <unique> <Space>c <Plug>(caw:i:toggle)
  silent! vmap <unique> <Space>c <Plug>(caw:i:toggle)

endif "}}}

if dein#tap('taglist.vim') "{{{

  " タグリストを開いた時にフォーカスを移す
  let Tlist_GainFocus_On_ToggleOpen = 1
  " 余分な情報や空白を表示しない
  let Tlist_Compact_Format = 1
  " タグリストをハイライトする
  let Tlist_Auto_Highlight_Tag = 1
  " タグを選択した際にタグリストを閉じる
  let Tlist_Close_On_Select = 1
  " 現在のファイルのタグリストのみを開く
  let Tlist_Show_One_File = 1
  " タグリストウィンドウのみしか存在しない時、vimを終了する
  let Tlist_Exit_OnlyWindow = 1
  " 新しくファイルを開いた際にタグリストを更新する
  let Tlist_Auto_Update = 1
  " タグリストの幅
  let Tlist_WinWidth = 30

  nnoremap <silent> <Space>t :<C-u>TlistToggle<CR>

endif "}}}

if dein#tap('emmet-vim') "{{{

  let g:user_emmet_leader_key = '<C-l>'
  let g:user_emmet_settings = {
        \  'lang' : 'ja',
        \  'html' : {
        \    'snippets' : {
        \      'rp' : '<%= | %>'
        \    },
        \    'filters' : 'html',
        \    'indentation' : ' '
        \  },
        \  'css' : {
        \    'filters' : 'fc',
        \  },
        \  'javascript' : {
        \    'snippets' : {
        \      'jq' : "$(function() {\n\t${cursor}${child}\n});",
        \      'jq:each' : "$.each(arr, function(index, item)\n\t${child}\n});",
        \      'fn' : "(function() {\n\t${cursor}\n})();",
        \      'tm' : "setTimeout(function() {\n\t${cursor}\n}, 100);",
        \    },
        \  },
        \}

endif "}}}

if dein#tap('VimClojure') "{{{

  let vimclojure#HighlightBuiltins=1
  let vimclojure#HighlightContrib=1
  let vimclojure#DynamicHighlighting=1
  let vimclojure#ParenRainbow=1
  let vimclojure#WantNailgun = 1
  let vimclojure#NailgunClient = "ng"

endif "}}}

if dein#tap('vim-quickrun') "{{{

  let g:quickrun_no_default_key_mappings = 1
  let g:quickrun_config = {}
  let g:quickrun_config.c = {
        \ 'command': 'clang'
        \ }
  let g:quickrun_config['cpp/clang++11'] = {
        \ 'cmdopt': '--std=c++11 --stdlib=libc++',
        \ 'type': 'cpp/clang++11'
        \ }
  let g:quickrun_config.cpp = {
        \ 'command': 'clang++',
        \ 'cmdopt'    : '-std=c++11 '
        \ }
  let g:quickrun_config.jsx = {
        \ 'command': 'jsx',
        \ 'args': '--run'
        \ }

  silent! nmap <unique> <Space>r <Plug>(quickrun)

  nnoremap <silent> <Space>js :<C-u>QuickRun -exec "jshint %S" >buffer:split=vertical<CR>

endif "}}}

if dein#tap('operator-camelize.vim') "{{{

  nmap cm <Plug>(operator-camelize-toggle)iw

endif "}}}

if dein#tap('ale') "{{{
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_linters = {
        \ 'go': ['go build'],
        \ }
endif "}}}

if dein#tap('syntastic') "{{{

  let g:syntastic_mode_map = {
        \  'mode': 'passive',
        \ 'active_filetypes': ['c', 'cpp', 'ruby', 'javascript', 'coffee', 'perl', 'go'],
        \ 'passive_filetypes': ['html', 'typescript', 'java', 'scala']
        \ }

  let g:syntastic_error_symbol = '✗'
  let g:syntastic_warning_symbol = '⚠'

  let g:syntastic_java_javac_options = '-Xlint -J-Dfile.encoding=UTF-8 -J-Duser.language=en'

  let g:syntastic_cpp_compiler_exec = 'clang'
  let g:syntastic_cpp_compiler_options = '--std=c++11 --stdlib=libc++'

  let g:syntastic_enable_perl_checker = 1
  let g:syntastic_perl_interpreter = '/Users/naoki.yaguchi/perl5/perlbrew/perls/perl-5.20.2/bin/perl'
  let g:syntastic_perl_lib_path = ['./lib', '/Users/naoki.yaguchi/npf/fujiyama-development/donguri/app/lib', '/Users/naoki.yaguchi/npf/fujiyama-development/karasuma/app/lib', '/Users/naoki.yaguchi/npf/fujiyama-development/matoba/app/lib', '/Users/naoki.yaguchi/npf/fujiyama-development/kiyamachi/app/lib', '/Users/naoki.yaguchi/npf/fujiyama-development/kiyamachi/app/t/lib', '/Users/naoki.yaguchi/npf/fujiyama-development/kiyamachi/perlbrew/lib/site_perl/5.20.2']
  let g:syntastic_perl_checkers = ['perl', 'podchecker']
  let g:syntastic_go_checkers = ['go', 'golint']

endif "}}}

if dein#tap('vim-powerline') "{{{

  let g:Powerline_symbols = 'fancy'

endif "}}}

if dein#tap('colorizer.git') "{{{

  let g:colorizer_nomap = 1
  nnoremap <Space>a :ColorToggle<CR>

endif "}}}

if dein#tap('ag.vim') "{{{
  nnoremap <Space>f :Ag <cword><CR>

endif "}}}

" if dein#tap('vim-multiple-cursors') "{{{
"
"   " nmap <C-J> <NOP>
"   let g:multi_cursor_use_default_mapping = 0
"   let g:multi_cursor_next_key = '<C-n>'
"   let g:multi_cursor_prev_key = '<C-p>'
"   let g:multi_cursor_skip_key = '<C-x>'
"   let g:multi_cursor_quit_key = '<Esc>'
"   let g:multi_cursor_start_key='<C-J>'
"
" endif "}}}

if dein#tap('vim-over') "{{{

  nnoremap <Space>o :OverCommandLine<CR>%s/

endif "}}}

if dein#tap('a.vim') "{{{

  nnoremap <Space>a :A<CR>

endif "}}}

if dein#tap('nerdtree') "{{{

  nnoremap <Space>nn :NERDTreeToggle<CR>

endif "}}}


filetype on
filetype plugin indent on


let g:vim_json_syntax_conceal = 0

"============================================================
" general settings
"============================================================
set helplang=ja                 " helpを日本語化
set iminsert=0 imsearch=0       " ?

" 前回の編集位置にカーソルを移動させる
augroup PrevCursor
  autocmd! PrevCursor
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" 改行時にコメントを引き継がない
set formatoptions+=mM
augroup LineBreak
  autocmd! LineBreak
  autocmd FileType * setlocal formatoptions-=ro
augroup END

set browsedir=current           " Exploreの初期ディレクトリ
set scrolloff=10                " スクロール時の余白
set autoread                    " ファイルが書き換えられたら自動で読み直す
set vb t_vb=                    " ビープ音を鳴らさない
set clipboard+=unnamed
set mouse=a
set path+=/usr/local/include
set path+=/usr/include/c++/4.2.1
set backspace=indent,eol,start
set virtualedit+=block
set foldtext=FoldCCtext()
set foldcolumn=4
set fillchars=vert:\|
set t_Co=256
set termguicolors

if !has('nvim')
  set ttymouse=xterm2
endif

if !has('gui_running')
  set timeout timeoutlen=1000 ttimeoutlen=75
endif

" サーチオプション
"----------------------------------------
set hlsearch            " 検索文字をハイライト
set incsearch           " インクリメンタルサーチ
set ignorecase          " 大文字小文字を無視
set smartcase           " 大文字が含まれている場合は大文字小文字を区別
nnoremap <Space><Space> :nohlsearch<CR>

let Grep_Skip_Dirs = '.svn .git'
let Grep_Skip_Files = '*.bak *~ *.swp'


" folding settings
"----------------------------------------
set foldmethod=marker
nnoremap zzc ggVGzc
nnoremap zzo ggVGzo


" エンコーディング
"----------------------------------------
set termencoding=utf-8
set encoding=utf-8
set fenc=utf-8
set fileencodings=utf-8,iso-2022-jp-3,iso-2022-jp,enc-jisx0213,euc-jp,ucs-bom,eucjp-ms,cp932
augroup Encoding
  autocmd! Encoding
  autocmd BufNew,BufRead,WinEnter COMMIT_EDITMSG setlocal enc=utf-8 fenc=utf-8
augroup END

" 指定したエンコーディングでファイルを開き直す
command! Cp932 edit ++enc=cp932
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2022-jp
command! Utf8 edit ++enc=utf-8
command! Jis Iso2022jp
command! Sjis Cp932

set scrolloff=10


" My keymap {{{

inoremap <C-A> <Home>
inoremap <C-E> <End>
nnoremap <silent> <Space>s i<Space><Right><Space><Left><Esc>
smap <C-H> <BS>i
inoremap <C-D> <Del>
inoremap <C-B> <Left>
inoremap <C-F> <Right>
nnoremap j g<Down>
nnoremap k g<Up>
nnoremap gj <Down>
nnoremap gk <Up>
nnoremap " <S-j>
nnoremap <S-j> <Nop>

" Fold {{{

" デフォルトのは使いにくいんで無効化する
nmap zd <NOP>
nmap zD <NOP>
nmap zE <NOP>
nmap zo <NOP>
nmap zO <NOP>
nmap zc <NOP>
nmap zC <NOP>
nmap za <NOP>
nmap zA <NOP>
nmap zv <NOP>
nmap zx <NOP>
nmap zX <NOP>
nmap zm <NOP>
nmap zM <NOP>
nmap zr <NOP>
nmap zR <NOP>
nmap zn <NOP>
nmap zN <NOP>
nmap zi <NOP>

nnoremap zn zM
nnoremap zp zR
nnoremap zh zc
nnoremap zl zo
nnoremap zo zMzv

"}}}

" }}}




" 英字配列キーボード用
"----------------------------------------
noremap ; :
noremap : ;



"============================================================
" appearance settings
"============================================================
set title                               " 端末のタイトルを表示
set ruler                               " 行番号と列番号を表示
set showmode                            " 現在のモードの表示
set number                              " 行番号表示
set ambiwidth=double                    " 一部のマルチバイト文字をascii2文字分の幅で表示
set display=uhex                        " 印字不可能文字を16進数で表示
set laststatus=2                        " ステータスラインを常時表示

set listchars=tab:>\-,eol:↩             " 不可視文字の設定
set titlestring=(」・ω・)」うー！(／・ω・)／にゃー！
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

set showmatch                           " カッコの対応をハイライト
set list                                " 不可視文字をハイライト

set lazyredraw                          " スクリプト実行中に画面を再描画しない
set ttyfast                             " 再描画を高速にする

syntax on
set background=dark

" 特殊な空白のハイライト
if has("syntax")
  function! ActivateInvisibleIndicator()
    syntax match InvisibleJISX0208Space "　" display containedin=ALL
    highlight InvisibleJISX0208Space term=underline ctermbg=darkgrey guibg=Blue
    syntax match InvisibleTrailedSpace "[ \t]\+$" display containedin=ALL
    highlight InvisibleTrailedSpace term=underline ctermbg=Red guibg=Red
  endf

  augroup invisible
    autocmd! invisible
    autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
  augroup END
endif

"入力モード時、ステータスラインのカラーを変更
augroup InsertHook
  autocmd!
  autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
  autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

" カーソルの行と列をハイライト
" augroup cch
"   autocmd! cch
"   autocmd WinLeave * set nocursorcolumn nocursorline
"   autocmd WinEnter,BufRead * set cursorcolumn cursorline
" augroup END


"============================================================
" indent settings
"============================================================
filetype indent on
colorscheme apprentice

set cindent             " Cライクな文法に従いインデント
set expandtab
set ts=2 sw=2 sts=2

augroup TabSize
  autocmd! TabSize
  autocmd FileType java       setlocal ts=4 sw=4 sts=4
  autocmd FileType javascript setlocal ts=2 sw=2 sts=2
  autocmd FileType perl       setlocal ts=4 sw=4 sts=4
  autocmd FileType c          setlocal ts=4 sw=4 sts=4
  autocmd FileType cpp        setlocal noexpandtab
  autocmd FileType json       setlocal ts=4 sw=4 sts=4
  autocmd FileType go         setlocal noexpandtab ts=4 sw=4 sts=4
augroup END


function! SetMyTab(sz)
  exec 'setlocal sw='.a:sz.' ts='.a:sz.' sts='.a:sz
endfunction

command! -nargs=1 Tb call SetMyTab(<args>)

function! FormatJSON()
  exec '%s/{/{/g'
  exec '%s/\[/[/g'
  exec '%s/}/}/g'
  exec '%s/\]/]/g'
  exec '%s/,/,/g'
  exec ':normal gg=G'
endfunction

command! F call FormatJSON()


"============================================================
" complement settings
"============================================================
set wildmenu        " 補完をwildmenu化
set complete+=k     " 補完に辞書ファイルを追加
set completeopt+=menuone
set completeopt-=preview

command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
  if 0 == a:0
    let l:arg = "."
  else
    let l:arg = a:1
  endif
  execute "%! jq \"" . l:arg . "\""
endfunction
