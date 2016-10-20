" .vimrc
set encoding=utf-8

" load up pathogen and all bundles
call pathogen#infect()
call pathogen#helptags()

syntax on                         " show syntax highlighting
filetype plugin indent on
set autoindent                    " set auto indent
set ts=2                          " set indent to 2 spaces
set shiftwidth=2
set expandtab                     " use spaces, not tab characters
set nocompatible                  " not old vi compatible
set relativenumber                " show relative line numbers
set showmatch                     " show bracket matches
set ignorecase                    " ignore case in search
set hlsearch                      " highlight all search matches
set cursorline                    " highlight current line
set smartcase                     " pay attention to case when caps are used
set incsearch                     " show search results as I type
set ttimeoutlen=100               " decrease timeout for faster insert with 'O'
set vb                            " enable visual bell (disable audio bell)
set ruler                         " show row and column in footer
set scrolloff=5                   " minimum lines above/below cursor
set laststatus=2                  " always show status line
set list listchars=tab:»·,trail:· " show extra space characters
set nofoldenable                  " disable code folding
set clipboard=unnamed             " use the system clipboard
set wildmenu                      " enable bash style tab completion
set wildmode=list:longest,full

set autoread                      " reload file when changes happen in other editors
set history=50
set undolevels=50
set bs=2                          " make backspace behave like normal again
" set wildignore+=*.pyc
" set wildignore+=*_build/*
" set wildignore+=*/coverage/*
runtime macros/matchit.vim        " use % to jump between start/end of methods

