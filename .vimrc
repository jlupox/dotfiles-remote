" .vimrc
set encoding=utf-8

" load up pathogen and all bundles
call pathogen#infect()
call pathogen#helptags()

syntax on                         " show syntax highlighting
let mapleader = ","               " set leader key to comma
filetype plugin indent on
set mouse=a                       " Mouse compatibility
set autoindent                    " set auto indent
set tabstop=4                     " set indent to 2 spaces
set softtabstop=4
set shiftwidth=4
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
nnoremap <Leader><Bar> <C-w>v     " Split vertical - <Bar> is |
nnoremap <Leader>- <C-w>s         " Split horizontal

" To open and close the navigator
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

function! NoNumberToggle()
  if(&relativenumber ==1)
    set norelativenumber
  else
    set nonumber
  endif
endfunc

nnoremap <Leader>l :call NumberToggle()<cr>
nnoremap <Leader>d :call NoNumberToggle()<cr>
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

set t_Co=256                      " 256 colors
set cursorline                    " highlight current line
set term=xterm-256color
set colorcolumn=80
let clrsch = 'wombat256'
colorscheme wombat256
highlight ColorColumn ctermbg=233

" highlight the status bar when in insert mode
if version >= 700
  au InsertEnter * hi StatusLine ctermfg=235 ctermbg=2
  au InsertLeave * execute "colorscheme " . clrsch
  au InsertLeave * hi ColorColumn ctermbg=233
endif

" play nicely with TABs in Makefiles
autocmd FileType make setlocal noexpandtab
autocmd FileType make setlocal nolist

" unmap F1 help
nmap <F1> <nop>
imap <F1> <nop>

" Clear search highlights
noremap <silent><Leader>/ :nohls<CR>

" ------------------------------------------------------------------
"  " To Copy/Paste using Clipboard
"  " ------------------------------------------------------------------
:set pastetoggle=<F2>

" ------------------------------------------------------------------
" For Airline
" ------------------------------------------------------------------
let g:airline_symbols = {}
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '^V' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '^S' : 'S',
    \ }

" ------------------------------------------------------------------
" For ctrlp
" ------------------------------------------------------------------
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_max_height = 30
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_reversed = 0
" use silver searcher for ctrlp
" let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" ------------------------------------------------------------------
" For Silver Searcher
" ------------------------------------------------------------------
map <leader>a :Ag!<space>

" ------------------------------------------------------------------
" For yang
" ------------------------------------------------------------------
au BufRead,BufNewFile *.yang set filetype=yang

" ------------------------------------------------------------------
" For vim-markdown
" ------------------------------------------------------------------
let g:vim_markdown_folding_disabled=1

" ------------------------------------------------------------------
" Remaps
" ------------------------------------------------------------------
" Jump functions => movement
map  gj ]m
map  gk [m
map  gn }
map  gp {

" Insert new line without entering insert mode
nmap gO O<Esc>
nmap go o<Esc>

" Insert a Space without entering insert mode
nmap <Space> i<Space><Esc>

" Edit to next underscore _
nnoremap c_ ct_

" Insert a hash rocket with <c-h>
imap <c-h> <space>=><space>

" Reload vimrc
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Mac reload CtrlP
nnoremap <F3> :CtrlPClearCache<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
