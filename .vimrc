scriptencoding utf-8

let $VIM_ROOT=$HOME.'/.vim'

"============================================================
" plugin settings
"============================================================

set nocompatible
filetype off
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=$VIM_ROOT/bundle/neobundle.vim/
  call neobundle#rc(expand($VIM_ROOT.'/bundle'))
endif

NeoBundle 'Shougo/neobundle.vim'
  NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/vimproc', {'build' : {'mac' : 'make -f make_mack.mak', 'unix' : 'make -f make_unix.mak'} }
  NeoBundle 'Shougo/vimshell', {'depends' : 'Shougo/vimproc' }
  NeoBundle 'Shougo/vimfiler'
NeoBundle 'neocomplcache'
  NeoBundle 'ujihisa/neco-ghc'
  NeoBundle 'Rip-Rip/clang_complete'
NeoBundle 'unite.vim'
  NeoBundle 'h1mesuke/unite-outline'
  NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'taglist.vim'
NeoBundle 'smartchr'
NeoBundle 'ZenCoding.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tpope/vim-surround'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'tyru/operator-camelize.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tyru/caw.vim'
NeoBundle 'Shougo/vinarise'
NeoBundle 'glidenote/memolist.vim'
NeoBundle 'ruby-matchit'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'ujihisa/neco-look.git'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'mariocesar/vimrc_local.vim'

NeoBundle 'VimClojure'
NeoBundle 'vim-scala'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'indenthaskell.vim'
NeoBundle 'haskell.vim'
NeoBundle 'cocoa.vim'
NeoBundle 'jsx/jsx.vim'
NeoBundle 'vim-scripts/nginx.vim'

filetype on
filetype plugin indent on

if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles' . string(neobundle#get_not_installed_bundle_names())
  echomsg 'Execute ":NeoBundleInstall" command.'
endif


" vundle setting
"----------------------------------------
nnoremap <silent> <Space>bi :<C-u>NeoBundleInstall<CR>
nnoremap <silent> <Space>bc :<C-u>NeoBundleClean<CR>
nnoremap <silent> <Space>bs :<C-u>NeoBundleSearch<CR>


" Unite.vim setting
"----------------------------------------
let g:unite_enable_start_insert=1
nnoremap <silent> <Space>uf :<C-u>Unite -buffer-name=files file file/new<CR>
nnoremap <silent> <Space>un :<C-u>Unite file/new<CR>
nnoremap <silent> <Space>ud :<C-u>Unite directory_mru<CR>
nnoremap <silent> <Space>ub :<C-u>Unite buffer<CR>
nnoremap <silent> <Space>ua :<C-u>Unite -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> <Space>us :<C-u>Unite snippet<CR>
nnoremap <silent> <Space>um :<C-u>Unite mapping<CR>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
endfunction


" neocomplcache setting
"----------------------------------------
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_auto_completion_start_length = 3
let g:neocomplcache_min_keyword_length = 4
let g:neocomplcache_enable_ignore_case = 0
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_camel_case_completion = 0 " input AE -> suggest ArgumentsException
let g:neocomplcache_snippets_dir = $VIM_ROOT.'/snippets'

let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default'         : '',
            \ 'java'            : $VIM_ROOT.'/dict/java14.dict'
            \ }
imap <C-j> <Plug>(neocomplcache_snippets_expand)
smap <C-j> <Plug>(neocomplcache_snippets_expand)
nnoremap <silent> <Space>ns :NeoComplCacheEditSnippets<CR>
inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
inoremap <expr><C-l> neocomplcache#complete_common_string()
inoremap <expr><TAB> pumvisible() ? neocomplcache#complete_common_string() : "\<TAB>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
imap <C-k>  <Plug>(neocomplcache_start_unite_complete)
inoremap <expr><C-x><C-o> &filetype == 'vim' ? "\<C-x><C-v><C-p>" : neocomplcache#manual_omni_complete()

" for clang_complete
let g:neocomplcache_force_overwrite_completefunc=1
let g:neocomplcache_force_overwrite_completefunc=1
if !exists("g:neocomplcache_force_omni_patterns")
  let g:neocomplcache_force_omni_patterns = {}
endif

" for omni complement
autocmd FileType *
      \   if &l:omnifunc == ''
      \ |   setlocal omnifunc=syntaxcomplete#Complete
      \ | endif
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.default = '\h\w*'
" let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php  = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.java = '[^. \t]\.\h\w*\'


" vimproc setting
"----------------------------------------
nnoremap <silent> <Space>vs :<C-u>VimShell<CR>
nnoremap <silent> <Space>vr :<C-u>VimShellInteractive irb<CR>


" matrix setting
"----------------------------------------
nnoremap <silent> <Space>m :<C-u>Matrix<CR>


" nerdcommenter setting
"----------------------------------------
let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
nmap co <Plug>NERDCommenterToggle
vmap co <Plug>NERDCommenterToggle

" caw.vim setting
"----------------------------------------



" taglist setting
"----------------------------------------
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


" ZenCoding setting
"----------------------------------------
let g:user_zen_leader_key = '<c-e>'
let g:user_zen_settings = {
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


" VimClojure setting
"----------------------------------------
let vimclojure#HighlightBuiltins=1
let vimclojure#HighlightContrib=1
let vimclojure#DynamicHighlighting=1
let vimclojure#ParenRainbow=1
let vimclojure#WantNailgun = 1
let vimclojure#NailgunClient = "ng"


" vim-indent-guides setting
"----------------------------------------
" let g:indent_guides_enable_on_vim_startup=0
" let g:indent_guides_auto_colors=0
" let g:indent_guides_start_level=2
" let g:indent_guides_guide_size=1
" autocmd VimEnter,ColorScheme * :hi IndentGuidesOdd  guibg=#121212 guifg=#242424 ctermbg=235 ctermfg=238
" autocmd VimEnter,ColorScheme * :hi IndentGuidesEven guibg=#262626 guifg=#525252 ctermbg=233 ctermfg=236


" quickrun setting
"----------------------------------------
let g:quickrun_no_default_key_mappings = 1
let g:quickrun_config = {}
let g:quickrun_config.c = {
            \ 'command': 'clang'
            \ }
" let g:quickrun_config.javascript = {
            " \ 'command': 'jshint',
            " \ 'outputter': 'buffer'
            " \ }
silent! nmap <unique> <Space>r <Plug>(quickrun)
nnoremap <silent> <Space>js :<C-u>QuickRun -exec "jshint %S" >buffer:split=vertical<CR>


" operator-camelize setting
"----------------------------------------
nmap cm <Plug>(operator-camelize-toggle)iw


" Smooth-Scroll setting
"----------------------------------------
" map <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
" map <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>


" Syntastic setting
"----------------------------------------
let g:syntastic_mode_map = {
      \  'mode': 'active',
      \ 'active_filetypes': ['ruby', 'javascript', 'coffee'],
      \ 'passive_filetypes': ['html', 'java', 'typescript', 'scala']
      \ }


" Project.vim setting
" ----------------------------------------
let g:proj_window_width=30
silent! nmap <unique> <Space>p <Plug>ToggleProject
function! LoadDefaultProject()
    if getcwd() != $HOME
        if filereadable(getcwd() . '/.vimprojects')
            Project .vimprojects
            call feedkeys(" p")
        endif
    endif
endfunction
autocmd VimEnter * call LoadDefaultProject()


" memolist setting
" ----------------------------------------
nnoremap <Space>mn :MemoNew<CR>
nnoremap <Space>ml :MemoList<CR>
nnoremap <Space>mg :MemoGrep<CR>
let g:memolist_path = $VIM_ROOT.'/memolist'

" tcomment_vim setting
" ----------------------------------------
let g:tcommentMapLeaderOp1 = 'co'
if !exists('g:tcomment_types')
	let g:tcomment_types = {}
endif
let g:tcomment_types.jsx = '// %s'

let g:highind_enable_at_startup = 0

" vim-powerline setting
" ----------------------------------------
let g:Powerline_symbols = 'fancy'

" vimrc_local setting
let g:local_vimrc = '.vimrc_local'


set nocompatible
filetype on
filetype plugin on




"============================================================
" general settings
"============================================================
set helplang=ja                 " helpを日本語化
set iminsert=0 imsearch=0       " ?

" 前回の編集位置にカーソルを移動させる
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" 改行時にコメントを引き継がない
set formatoptions+=mM
autocmd FileType * setlocal formatoptions-=ro

set shellslash                  " スラッシュを区切りにしてファイル名を展開する
set textwidth=1000              " 右端で折り返さない
set browsedir=current           " Exploreの初期ディレクトリ
set scrolloff=10                " スクロール時の余白
set autoread                    " ファイルが書き換えられたら自動で読み直す
set vb t_vb=                    " ビープ音を鳴らさない
set clipboard+=unnamed,autoselect
set mouse=a
set ttymouse=xterm2


" サーチオプション
"----------------------------------------
set hlsearch            " 検索文字をハイライト
set incsearch           " インクリメンタルサーチ
set ignorecase          " 大文字小文字を無視
set smartcase           " 大文字が含まれている場合は大文字小文字を区別
nnoremap <Esc><Esc> :nohlsearch<CR>

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
set fileencodings=iso-2022-jp-3,iso-2022-jp,enc-jisx0213,euc-jp,utf-8,ucs-bom,eucjp-ms,cp932
autocmd BufNew,BufRead,WinEnter COMMIT_EDITMSG setlocal enc=utf-8 fenc=utf-8

" 指定したエンコーディングでファイルを開き直す
command! Cp932 edit ++enc=cp932
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2022-jp
command! Utf8 edit ++enc=utf-8
command! Jis Iso2022jp
command! Sjis Cp932

set scrolloff=10


" My keymap
"----------------------------------------
cmap <C-A> <Home>
cmap <C-E> <End>
cmap <C-F> <Right>
cmap <C-B> <Left>
nnoremap <silent> <Space><Space> :<C-u>source ~/.vimrc<CR>
nnoremap <silent> <Space>s i<Space><Right><Space><Left><Esc>
smap <C-H> <BS>
inoremap <C-D> <Del>
inoremap <C-B> <Left>
inoremap <C-F> <Right>



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

set listchars=tab:>\-,eol:$             " 不可視文字の設定
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
        syntax match InvisibleTab "$" display containedin=ALL
        highlight InvisibleTab term=underline ctermbg=Red guibg=Red
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
augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorcolumn nocursorline
    autocmd WinEnter,BufRead * set cursorcolumn cursorline
augroup END

" java highlight
let java_highlight_all=1




"============================================================
" indent settings
"============================================================
filetype indent on
colorscheme yuroyoro256

set cindent             " Cライクな文法に従いインデント
set expandtab
set ts=4 sw=4 sts=4

autocmd BufNew,BufRead,WinEnter *.zshrc  setlocal ts=2 sw=2 sts=2
autocmd BufNew,BufRead,WinEnter *.rb     setlocal ts=2 sw=2 sts=2
autocmd BufNew,BufRead,WinEnter *.erb    setlocal ts=2 sw=2 sts=2
autocmd BufNew,BufRead,WinEnter *.html   setlocal ts=2 sw=2 sts=2
autocmd BufNew,BufRead,WinEnter *.java   setlocal ts=4 sw=4 sts=4
autocmd BufNew,BufRead,WinEnter *.js     setlocal ts=4 sw=4 sts=4 filetype=javascript
autocmd BufNew,BufRead,WinEnter *.ejs    setlocal ts=2 sw=2 sts=2 filetype=html
autocmd BufNew,BufRead,WinEnter *.coffee setlocal ts=2 sw=2 sts=2 filetype=coffee


function! SetMyTab(sz)
  exec 'set sw='.a:sz.' ts='.a:sz.' sts='.a:sz
endfunction

command! -nargs=1 Tb call SetMyTab(<args>)



"============================================================
" complement settings
"============================================================
set wildmenu        " 補完をwildmenu化
set complete+=k     " 補完に辞書ファイルを追加

set autoread
set updatetime=50

let s:system = exists('g:loaded_vimproc') ? 'vimproc#system_bg' : 'system'

augroup vim-auto-typescript
    autocmd!
    " 適当なタイミングで再読み込み
    autocmd CursorHold   *.ts :checktime
    autocmd CursorMoved  *.ts :checktime

    " 書き込み時に js に出力する
    autocmd BufWritePost *.ts :call {s:system}("tsc game.ts")
augroup END

