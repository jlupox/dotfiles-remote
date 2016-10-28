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

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Easy split navigation
nnoremap <S-h> <C-w>h
nnoremap <S-j> <C-w>j
nnoremap <S-k> <C-w>k
nnoremap <S-l> <C-w>l
" split almost tmux conf
nnoremap <Leader><Bar> <C-w>v               " Split vertical - <Bar> is |
nnoremap <Leader>- <C-w>s                   " Split horizontal

" To open the navigator
nnoremap <Leader>e :Ex<CR>
nnoremap <Leader>q :bd<CR>

" Awesome line number magic
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set relativenumber
    set nonumber
  endif
endfunc

nnoremap <Leader>l :call NumberToggle()<cr>
:au FocusLost * set number
:au FocusGained * set relativenumber
autocmd InsertEnter * set number
autocmd InsertLeave * set relativenumber
set relativenumber

" Show trailing whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/
map <Leader>x :%s/\s\+$//<Return>

" jump to last position in file when open
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" |
  \ endif

" My ColorSchemeToggle
function! ColorSchemeToggle()
  " if(s:colorscheme == 'solarized')
  if(s:colorscheme != 'wombat')
    colorscheme wombat256mod
    " highlight ColorColumn ctermbg=233
    let s:colorscheme = 'wombat256mod'
  else
    colorscheme wombat256
    let s:colorscheme = 'wombat256'
  endif
endfunc
nnoremap <Leader>c :call ColorSchemeToggle()<cr>

set t_Co=256 " 256 colors"
set cursorline                            " highlight current line
set term=xterm-256color
set colorcolumn=80
colorscheme wombat256mod
highlight ColorColumn ctermbg=233
" let s:colorscheme = 'wombat'

