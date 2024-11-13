" -----------------------------
" Basic Settings
" -----------------------------
set nocompatible
filetype off
set shell=/bin/bash

" -----------------------------
" Plugin Management
" -----------------------------
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Core Plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'               " Git integration
Plugin 'itchyny/lightline.vim'            " Status line
Plugin 'airblade/vim-gitgutter'           " Git diff in sign column

" Navigation and UI
Plugin 'easymotion/vim-easymotion'        " Quick navigation
Plugin 'scrooloose/nerdtree'              " File explorer
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'psliwka/vim-smoothie'             " Smooth scrolling
Plugin 'ap/vim-buftabline'                " Buffer tabs
Plugin 'el-iot/buffer-tree-explorer'      " Buffer tree

" Editing and Completion
Plugin 'jiangmiao/auto-pairs'             " Auto pair brackets
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
Plugin 'Exafunction/codeium.vim'          " AI completion
Plugin 'junegunn/goyo.vim'                " Distraction-free writing

call vundle#end()
filetype plugin indent on

" -----------------------------
" Editor Settings
" -----------------------------
" General
set hidden
set noshowmode
set laststatus=2
set background=dark
syntax enable

" Indentation
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab

" Display
set relativenumber
set number
set backspace=indent,eol,start
set foldmethod=indent
set foldcolumn=1
set nofoldenable

" Search
set incsearch
set hlsearch

" Performance
set lazyredraw
set mouse-=a
set noerrorbells
set novisualbell
set t_vb=
set t_u7=
set t_RV=
set tm=500

" -----------------------------
" File-specific Settings
" -----------------------------
autocmd Filetype python,json setlocal ts=4 sw=4
au FileType python setlocal formatprg=autopep8\ -
autocmd FileType typescript,typescriptreact,javascript,javascriptreact,ruby setlocal ts=2 sw=2

" -----------------------------
" Theme
" -----------------------------
colorscheme atom-dark-256

" -----------------------------
" Key Mappings
" -----------------------------
let mapleader = ','

" Navigation
map <Leader> <Plug>(easymotion-prefix)
nnoremap <C-h> :bprevious<CR>
nnoremap <C-l> :bnext<CR>
nnoremap <Leader>q :bd<CR>
nnoremap <Leader>[ :Tree<CR>

" Features
map <Leader>o :NERDTree<CR>
map <Leader>V :Goyo<CR>
map <Leader>c gggqG<CR>

" Code Navigation and Inspection
nnoremap <silent> K :call ShowDocumentation()<CR>
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>qf <Plug>(coc-fix-current)
nmap <leader>f <Plug>(coc-format)

" Codeium
imap <C-s> <Cmd>call codeium#Complete()<CR>
imap <C-j> <Cmd>call codeium#CycleCompletions(1)<CR>
imap <C-k> <Cmd>call codeium#CycleCompletions(-1)<CR>
imap <C-x> <Cmd>call codeium#Clear()<CR>

" -----------------------------
" Plugin Configurations
" -----------------------------
" NERDTree
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeQuitOnOpen = 1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Lightline
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

" Buffer Tree
let g:buffertree_close_on_enter = 1
let g:buffer_tree_explorer_compress = 1

" Goyo
let g:goyo_width = 90
function! s:goyo_enter()
  set number
  GitGutterEnable
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()

" CoC
let g:coc_global_extensions = [
      \ 'coc-pyright',
      \ 'coc-tsserver',
      \ 'coc-solargraph',
      \ 'coc-prettier',
      \ 'coc-eslint',
      \ 'coc-json',
      \ 'coc-css',
      \ 'coc-html'
      \ ]

let g:coc_user_config = {
      \ 'python.analysis.typeCheckingMode': 'basic',
      \ 'python.analysis.diagnosticMode': 'workspace',
      \ 'pyright.inlayHints.functionReturnTypes': v:true,
      \ 'pyright.inlayHints.variableTypes': v:true,
      \ 'python.formatting.provider': 'black',
      \ 'python.linting.enabled': v:true,
      \ 'python.linting.pylintEnabled': v:true,
      \ 'python.linting.flake8Enabled': v:true,
      \ 'tsserver.enable': v:true,
      \ 'typescript.format.enabled': v:true,
      \ 'typescript.suggestionActions.enabled': v:true,
      \ 'typescript.preferences.importModuleSpecifier': 'relative',
      \ 'typescript.inlayHints.functionLikeReturnTypes.enabled': v:true,
      \ 'typescript.inlayHints.variableTypes.enabled': v:true,
      \ 'typescript.suggest.autoImports': v:true,
      \ 'javascript.format.enabled': v:true,
      \ 'javascript.suggest.autoImports': v:true,
      \ 'javascript.updateImportsOnFileMove.enabled': 'always',
      \ 'eslint.autoFixOnSave': v:true,
      \ 'prettier.requireConfig': v:true,
      \ 'prettier.onlyUseLocalVersion': v:true,
      \ 'solargraph.diagnostics': v:true,
      \ 'solargraph.autoformat': v:true,
      \ 'solargraph.formatting': v:true,
      \ 'solargraph.hover': v:true,
      \ 'solargraph.checkGemVersion': v:false,
      \ 'suggest.noselect': v:true,
      \ 'suggest.enablePreselect': v:false,
      \ 'suggest.removeDuplicateItems': v:true,
      \ 'diagnostic.errorSign': '✗',
      \ 'diagnostic.warningSign': '⚠',
      \ 'diagnostic.infoSign': 'ℹ',
      \ 'diagnostic.hintSign': '➤'
      \ }


" -----------------------------
" Helper Functions
" -----------------------------
function! LightlineGitGutter()
  if !get(g:, 'gitgutter_enabled', 0) || empty(FugitiveHead())
    return ''
  endif
  let [ l:added, l:modified, l:removed ] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', l:added, l:modified, l:removed)
endfunction

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Highlight references
autocmd CursorHold * silent call CocActionAsync('highlight')
