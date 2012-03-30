" vundle setting
"----------------------------------------
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'unite.vim'
Bundle 'neocomplcache'
Bundle 'Indent-Guides'
Bundle 'tComment'
Bundle 'rails.vim'
Bundle 'taglist.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'smartchr'
Bundle 'ZenCoding.vim'




filetyp plugin indent on

nnoremap <silent> <Space>bi :<C-u>BundleInstall<CR>
nnoremap <silent> <Space>bc :<C-u>BundleClean<CR>
nnoremap <silent> <Space>bs :<C-u>BundleSearch<CR>


" Unite.vim setting
"----------------------------------------
let g:unite_enable_start_insert=1
nnoremap <silent> <Space>uf :<C-u>Unite file<CR>
nnoremap <silent> <Space>ub :<C-u>Unite buffer<CR>
nnoremap <silent> <Space>ua :<C-u>Unite -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> <Space>us :<C-u>Unite snippets<RC>


" neocomplcache setting
"----------------------------------------
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_auto_select=1
imap <C-j> <Plug>(neocomplcache_snippets_expand)
smap <C-j> <Plug>(neocomplcache_snippets_expand)
nnoremap <silent> ns :NeoComplCacheEditSnippets<CR>
inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
inoremap <expr><C-l> neocomplcache#complete_common_string()
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"



" matrix setting
"----------------------------------------
nnoremap <silent> <Space>m :<C-u>Matrix<CR>


" TComment setting
"----------------------------------------
nnoremap <silent> co :TComment<CR>


" taglist setting
"----------------------------------------
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Auto_Update = 1
let Tlist_WinWidth = 30
nnoremap <silent> <Space>t :<C-u>TlistToggle<CR>


" ZenCoding setting
"----------------------------------------
let g:user_zen_leader_key = '<c-e>'


" ハイライト
"----------------------------------------
syntax enable
set background=dark

" let g:solarized_termcolors = 256
" let g:solarized_termtrans  = 1
" let g:solarized_degrade    = 1
" let g:solarized_bold       = 1
" let g:solarized_underline  = 1
" let g:solarized_italic     = 1
" let g:solarized_contrast   = "low"
" let g:solarized_visibility = "low"
colorscheme desert256


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

hi scalaNew gui=underline
hi scalaMethodCall gui=italic
hi scalaValName gui=underline
hi scalaVarName gui=underline

"入力モード時、ステータスラインのカラーを変更
"----------------------------------------
augroup InsertHook
    autocmd!
    autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
    autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

au BufRead,BufNewFile *.scala set filetype=scala

" 日本語設定
"----------------------------------------
set helplang=ja
set iminsert=0 imsearch=0

" カーソル位置
"----------------------------------------
augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorcolumn nocursorline
    autocmd WinEnter,BufRead * set cursorcolumn cursorline
augroup END


" インデント
set autoindent
set smartindent
set cindent
set backspace=indent,eol,start
set showmatch
set showmode
set title
set ruler
set wildmenu
set formatoptions+=mM
set ambiwidth=double
let g:indent_guides_enable_on_vim_startup = 0

set expandtab ts=4 sw=4 sts=4
set list listchars=tab:>\-,eol:$,trail:*

autocmd BufNew,BufRead *.zshrc set ts=2 sw=2 sts=2
autocmd BufNew,BufRead *.rb set ts=2 sw=2 sts=2
autocmd BufNew,BufRead *.erb set ts=2 sw=2 sts=2
autocmd BufNew,BufRead *.html set ts=2 sw=2 sts=2
autocmd BufNew,BufRead COMMIT_EDITMSG set enc=utf-8 fenc=utf-8
autocmd FileType * setlocal formatoptions-=ro


" サーチオプション
"----------------------------------------
set hlsearch
set incsearch


" 前回の編集位置にカーソルを移動させる
"----------------------------------------
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" ステータスライン
"----------------------------------------
set number
set laststatus=2
" set statusline=\[%n%{bufnr('$')>1?'/'.bufnr('$'):''}%{winnr('$')>1?':'.winnr().'/'.winnr('$'):''}\]\ %<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l/%L,%c%V%8P
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

" エンコーディング
"----------------------------------------
set termencoding=utf-8
set fileencodings=iso-2022-jp-3,iso-2022-jp,enc-jisx0213,euc-jp,utf-8,ucs-bom,eucjp-ms,cp932
set fenc=utf-8
" set enc=utf-8

set browsedir=current
set shellslash
set scrolloff=10
set display=lastline

" My keymap
"----------------------------------------
cmap <C-A> <Home>
cmap <C-E> <End>
cmap <C-F> <Right>
cmap <C-B> <Left>
nnoremap <Esc><Esc> :nohlsearch<CR>
nnoremap <silent> <Space><Space> :<C-u>source ~/.vimrc<CR>
smap <C-H> <BS>

" 英字配列キーボード用
"----------------------------------------
noremap ; :
noremap : ;

