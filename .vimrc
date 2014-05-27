set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/Vundle.vim'
" My Bundles here:
"
" original repos on github
Bundle 'scrooloose/nerdtree'
Bundle 'shawncplus/php.vim'
Bundle 'othree/html5.vim'
Bundle 'an1zhegorodov/vim-colorschemes'
Bundle 'kshenoy/vim-signature'
"Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/simple-pairs'
"Bundle 'ludovicPelle/vim-xdebug'
"Bundle 'tpope/vim-fugitive'
"Bundle 'Lokaltog/vim-easymotion'
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"Bundle 'tpope/vim-rails.git'
" vim-scripts repos
"Bundle 'L9'
"Bundle 'FuzzyFinder'
" non github repos
"Bundle 'git://git.wincent.com/command-t.git'
" git repos on your local machine (ie. when working on your own plugin)
"Bundle 'file:///Users/gmarik/path/to/plugin'
" ...

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
set t_Co=256
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set number
set ruler
colorscheme github

" Switch to normal mode when in insert mode
:imap jj <Esc>

" Switch between tabs with Ctrl-h/l
:map <C-h> :tabp<Enter>
:map <C-l> :tabn<Enter>

" ; Adds a semicolon to the end of the line when in normal mode
noremap ; :s/\([^;]\)$/\1;/<cr>:nohls<cr>

" Remove newline symbol at the end of php files (damn ?>)
au BufWritePre *.php :set binary | set noeol
au BufWritePost *.php :set nobinary | set eol

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

if has('gui_running')
      set guifont=Liberation\ Mono\ 9
endif
