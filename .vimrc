" TODO
" yuroyoroさんの使っているpluginをひと通り見る
" 補完をいじる
" vim-indent-guidesをいじる



"============================================================
" plugin settings
"============================================================

set nocompatible
filetype off
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache-snippets-complete'
NeoBundle 'unite.vim'
NeoBundle 'neocomplcache'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'taglist.vim'
NeoBundle 'smartchr'
NeoBundle 'ZenCoding.vim'
NeoBundle 'VimClojure'
NeoBundle 'vim-scala'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'osyo-manga/unite-u-nya-'
NeoBundle 'koron/u-nya-vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'cocoa.vim'


filetype on
filetype plugin indent on


" vundle setting
"----------------------------------------
nnoremap <silent> <Space>bi :<C-u>NeoBundleInstall<CR>
nnoremap <silent> <Space>bc :<C-u>NeoBundleClean<CR>
nnoremap <silent> <Space>bs :<C-u>NeoBundleSearch<CR>


" Unite.vim setting
"----------------------------------------
let g:unite_enable_start_insert=1
nnoremap <silent> <Space>uf :<C-u>Unite file<CR>
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
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_auto_select=1
let g:neocomplcache_snippets_dir = $HOME.'/.vim/snippets'
let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default'         : '',
            \ 'java'            : $HOME.'/.vim/dict/java14.dict'
            \ }
imap <C-j> <Plug>(neocomplcache_snippets_expand)
smap <C-j> <Plug>(neocomplcache_snippets_expand)
nnoremap <silent> ns :NeoComplCacheEditSnippets<CR>
inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
inoremap <expr><C-l> neocomplcache#complete_common_string()
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"


" matrix setting
"----------------------------------------
nnoremap <silent> <Space>m :<C-u>Matrix<CR>


" nerdcommenter setting
"----------------------------------------
let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
nmap co <Plug>NERDCommenterToggle
vmap co <Plug>NERDCommenterToggle


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
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors=0
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
autocmd VimEnter,ColorScheme * :hi IndentGuidesOdd  guibg=#121212 ctermbg=235
autocmd VimEnter,ColorScheme * :hi IndentGuidesEven guibg=#262626 ctermbg=233


" quickrun setting
"----------------------------------------
let g:quickrun_no_default_key_mappings = 1
silent! nmap <unique> <Space>r <Plug>(quickrun)


set nocompatible
filetype on
filetype plugin on




"============================================================
" general settings
"============================================================
set helplang=ja                 " helpを日本語化
set iminsert=0 imsearch=0       " ?

" scalaファイルを認識させる
autocmd BufNew,BufRead,WinEnter *.scala setlocal filetype=scala

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


" サーチオプション
"----------------------------------------
set hlsearch            " 検索文字をハイライト
set incsearch           " インクリメンタルサーチ
set ignorecase          " 大文字小文字を無視
set smartcase           " 大文字が含まれている場合は大文字小文字を区別
nnoremap <Esc><Esc> :nohlsearch<CR>

let Grep_Skip_Dirs = '.svn .git'
let Grep_Skip_Files = '*.bak *~ *.swp'


" エンコーディング
"----------------------------------------
set termencoding=utf-8
set encoding=utf-8
set fenc=utf-8
set fileencodings=iso-2022-jp-3,iso-2022-jp,enc-jisx0213,euc-jp,utf-8,ucs-bom,eucjp-ms,cp932
autocmd BufNew,BufRead,WinEnter COMMIT_EDITMSG set enc=utf-8 fenc=utf-8

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

set listchars=tab:>\-,eol:$,trail:_     " 不可視文字の設定
set titlestring=(」・ω・)」うー！(／・ω・)／にゃー！
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]\ %{g:U_nya_()}

set showmatch                           " カッコの対応をハイライト
set list                                " 不可視文字をハイライト

set lazyredraw                          " スクリプト実行中に画面を再描画しない
set ttyfast                             " 再描画を高速にする

syntax on
colorscheme yuroyoro256
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
  if a:sz==1
    set sw=1 ts=1 sts=1
  elseif a:sz==2
    set sw=2 ts=2 sts=2
  elseif a:sz==3
    set sw=3 ts=3 sts=3
  elseif a:sz==4
    set sw=4 ts=4 sts=4
  elseif a:sz==5
    set sw=5 ts=5 sts=5
  elseif a:sz==6
    set sw=6 ts=6 sts=6
  elseif a:sz==7
    set sw=7 ts=7 sts=7
  elseif a:sz==8
    set sw=8 ts=8 sts=8
  elseif a:sz==9
    set sw=9 ts=9 sts=9
  endif
endfunction

command! -nargs=1 Tb call SetMyTab(<args>)



"============================================================
" complement settings
"============================================================
set wildmenu        " 補完をwildmenu化
set complete+=k     " 補完に辞書ファイルを追加
