set nocompatible              " be iMproved, required
filetype off                  " required


set shell=/bin/bash
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'itchyny/lightline.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'scrooloose/nerdtree'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'airblade/vim-gitgutter'
Plugin 'jiangmiao/auto-pairs'
Plugin 'junegunn/goyo.vim'
Plugin 'dense-analysis/ale'
Plugin 'psliwka/vim-smoothie'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'Exafunction/codeium.vim'
Plugin 'ap/vim-buftabline'
Plugin 'el-iot/buffer-tree-explorer'
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
set nofoldenable
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

" Theme
set background=dark
syntax enable
colorscheme atom-dark-256

" Lightline
set laststatus=2
set noshowmode
function! LightlineGitGutter()
  if !get(g:, 'gitgutter_enabled', 0) || empty(FugitiveHead())
    return ''
  endif
  let [ l:added, l:modified, l:removed ] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', l:added, l:modified, l:removed)
endfunction
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 'gitbranch', 'gitgutter' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'codeium', 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component': {
      \   'codeium': '%{codeium#GetStatusString()}'
      \ },
      \ 'component_function': {
      \   'gitgutter': 'LightlineGitGutter',
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

" YCM
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_python_binary_path = 'python'

" Codeium
imap <C-s> <Cmd>call codeium#Complete()<CR>
imap <C-j> <Cmd>call codeium#CycleCompletions(1)<CR>
imap <C-k> <Cmd>call codeium#CycleCompletions(-1)<CR>
imap <C-x> <Cmd>call codeium#Clear()<CR>

" Toggle Python SQL Syntax Highlighting
command! ToggleSqlSyntax call ToggleSqlSyntax()
function! ToggleSqlSyntax()
  if exists("b:highlight_sql")
    syn clear SQLEmbedded
    syn clear pythonString
    syn clear pythonRawString
    unlet b:highlight_sql

    syn enable
    unlet! b:current_syntax_spell
  else
    unlet b:current_syntax
    syn include @SQL syntax/sql.vim
    syn region pythonString matchgroup=pythonQuotes
          \ start=+[uU]\=\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
          \ contains=pythonEscape,@Spell keepend
    syn region  pythonRawString matchgroup=pythonQuotes
          \ start=+[uU]\=[rR]\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
          \ contains=@Spell keepend
    syn region SQLEmbedded contains=@SQL containedin=pythonString,pythonRawString contained
          \ start=+\v(ALTER|BEGIN|CALL|COMMENT|COMMIT|CONNECT|CREATE|DELETE|DROP|END|EXPLAIN|EXPORT|GRANT|IMPORT|INSERT|LOAD|LOCK|MERGE|REFRESH|RENAME|REPLACE|REVOKE|ROLLBACK|SELECT|SET|TRUNCATE|UNLOAD|UNSET|UPDATE|UPSERT|WITH)+
          \ end=+;+
    let b:current_syntax = "pysql"
    let b:highlight_sql = 1
  endif
endfunction

" Buffer changing
set hidden
let g:buffertree_close_on_enter = 1
let g:buffer_tree_explorer_compress = 1
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprevious<CR>
nnoremap <Leader>q :bd<CR>
nnoremap <Leader>[ :Tree<CR>
