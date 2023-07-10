set nocompatible              " be iMproved, required
filetype off                  " required


set shell=/bin/bash
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'FelikZ/ctrlp-py-matcher'
Plugin 'jacoborus/tender.vim'
Plugin 'rakr/vim-one'
Plugin 'zanglg/nova.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'scrooloose/nerdtree'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'jiangmiao/auto-pairs'
Plugin 'junegunn/goyo.vim'
Plugin 'dense-analysis/ale'
Plugin 'psliwka/vim-smoothie'
call vundle#end()


filetype plugin indent on
set tabstop=2
set shiftwidth=2
autocmd Filetype python setlocal ts=4 sw=4
autocmd Filetype json setlocal ts=4 sw=4
set expandtab
set smarttab
set relativenumber
set mouse-=a
set hlsearch
set foldmethod=indent
set lazyredraw
set noerrorbells
set novisualbell
set t_vb=
set t_u7=
set t_RV=
set tm=500
set foldcolumn=1
set backspace=indent,eol,start

"NERDTree
set incsearch
let mapleader = ','
map <Leader> <Plug>(easymotion-prefix)
map <Leader>o :NERDTree<CR>
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowLineNumbers=1
let NERDTreeQuitOnOpen=1

"PyFlake
let g:PyFlakeOnWrite = 1

" Theme
set background=dark
syntax enable
colorscheme atom-dark-256

" Lightline
set laststatus=2
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" Goyo
let g:goyo_width = 90
function! s:goyo_enter()
  set number
  GitGutterEnable
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()
map <Leader>V :Goyo<CR>

" Formatting
au FileType python setlocal formatprg=autopep8\ -
map <Leader>c gggqG<CR>

" Override Jedi Vim
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_stubs_command = "<leader>x"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
