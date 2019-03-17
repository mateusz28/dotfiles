set nocompatible              " be iMproved, required
filetype off                  " required

" Specify a directory for plugins
" " - For Neovim: ~/.local/share/nvim/plugged
" " - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
"
" " Make sure you use single quotes
" let Vundle manage Vundle, required
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Chiel92/vim-autoformat'
Plug 'vim-scripts/AutoTag'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-clang'
Plug 'zchee/deoplete-jedi'
Plug 'rbong/galvanize.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'mattn/emmet-vim'
if v:version >= 704
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
endif
Plug 'w0rp/ale'

call plug#end()            " required

"Display settings
set splitright
" set terminal 256 color version
set t_Co=256
" colorscheme settings
let g:lucius_style = 'dark'
let g:lucius_no_term_bg = 1
colorscheme lucius
"Needed to preserve background color
set t_ut=
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
"Default vertical separator
"set fillchars+=vert:│

"enabe project specified vimrc files
set exrc

"Disable swap file
set noswapfile

"When next buffer is opened the currently modified one goes into background
set hidden

"Enable mouse
set mouse=a

"Enable exit/write confirmation
"
set confirm
set relativenumber
set number

"Tag file names vim searches in current directory and up until it finds it
set tags=./tags;/

" Keep undo history across sessions, by storing in file.
" Only works all the time.

silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" Display tabs and trailing spaces visually
set list listchars=trail:·,tab:┊\ ,extends:>,precedes:<,nbsp:·

"Syntax highlighting
syntax on

"Default indentation settings
set autoindent
set cindent
set tabstop=2 shiftwidth=2 expandtab
"Always show status bar
set laststatus=2

"Set - as default leader character
let mapleader = "-"
"Search options
set hlsearch
set ignorecase
set incsearch
set wildignore+=*.so,*.swp,*.zip,*.o,*.pyc     " MacOSX/Linux

"allow backspace to remove neline and indentation in insert mode
set backspace=indent,eol,start

" nerdTree options
"nerd tree never changes root directory except when decides differnetly
let g:NERDTreeChDirMode       = 0
nmap <leader>ne :NERDTreeToggle<CR>

"Snippets options
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsListSnippets="<c-v>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" statusline options
set statusline+=%#warningmsg#
set statusline+=%*

"Enabled extended tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"Autoformatter options
let g:formatdef_my_custom_c = '"astyle -A7 --mode=c -pcHs".&shiftwidth'
let g:formatters_c = ['my_custom_c']

"Autoformatter mapping
nmap <leader>af :Autoformat<CR>

"Deoplete options
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
" Use deoplete.
let g:deoplete#enable_at_startup = 1

let g:deoplete#sources#clang#libclang_path = "/usr/lib/x86_64-linux-gnu/libclang-3.8.so.1"
let g:deoplete#sources#clang#clang_header ="/usr/include/clang/"

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
  endif

set completeopt-=preview

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1
" Asynchronous Lint Engine Options
let g:ale_pattern_options = {
\   '.c$': {
\       'ale_linters': ['clangtidy'],
\       'ale_fixers': ['clang-format'],
\   },
\   '.py$': {
\       'ale_linters': ['pylint'],
\   },
\}

" Fzf options
let g:fzf_history_dir = '~/.local/share/fzf-history'
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

au FileType c setlocal fo-=c fo-=r fo-=o
"Additional mapping
"Paste mode togglig for copying big parts of files
nnoremap <Leader>p :set invpaste paste? <CR>
"Repeat search
vnoremap // y/<C-R>"<CR>
"Center after jump
nnoremap <c-]> <c-]>z.
nnoremap <c-o> <c-o>z.
nnoremap <c-i> <c-i>z.
nnoremap <n> <n>z.
nnoremap <N> <N>z.
"fzf.vim
nnoremap <c-t> :Files<CR>
nnoremap <Leader>ag :Ag<CR>
nnoremap <Leader>at :Tags<CR>
nnoremap <Leader>ab :Buffers<CR>
nnoremap <Leader>ah :History<CR>

"Faster and smoother movement
nnoremap <c-y> 3<c-y>
nnoremap <c-e> 3<c-e>
nmap <leader>gs :Gstatus<CR>
nmap <leader>gd :Gdiff<CR>
nnoremap Q <Nop>
map <leader>- -
