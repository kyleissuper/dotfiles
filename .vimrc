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
"Plugin 'tmhedberg/SimpylFold'
"Plugin 'vim-scripts/indentpython.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'jiangmiao/auto-pairs'
Plugin 'junegunn/goyo.vim'
Plugin 'vim-syntastic/syntastic'
call vundle#end()


filetype plugin indent on
set tabstop=2
set shiftwidth=2
autocmd Filetype python setlocal ts=4 sw=4
autocmd Filetype json setlocal ts=4 sw=4
"set paste
set expandtab
set smarttab
set relativenumber
set mouse-=a
set hlsearch
set foldmethod=indent
"set nofoldenable
"syntax on
"colorscheme default
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

"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
endif

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

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_javascript_eslint_args=['--cache']
let g:syntastic_javascript_eslint_exe=['eslint_d']
let g:syntastic_javascript_eslint_exec=['/bin/ls']
let g:syntastic_loc_list_height = 5

" Override Jedi Vim
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_stubs_command = "<leader>x"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
