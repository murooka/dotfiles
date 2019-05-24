scriptencoding utf-8
let g:mapleader="\<Space>"
let $VIM_ROOT=$HOME.'/.vim'



if &compatible
  set nocompatible
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif



" key mappings not depending on plugins
nnoremap <Leader><Leader> :source ~/.config/nvim/init.vim<CR>
noremap ; :
noremap : ;


" if dein#tap('Shougo/neosnippet.vim')
  let g:neosnippet#snippets_directory = $VIM_ROOT.'/snippets'

  imap <C-j>     <Plug>(neosnippet_expand_or_jump)
  smap <C-j>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-j>     <Plug>(neosnippet_expand_target)

  nnoremap <silent> <Space>ns :NeoSnippetEdit<CR>

" endif
