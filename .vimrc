set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Chiel92/vim-autoformat'
Plugin 'bling/vim-airline'
Plugin 'vim-scripts/AutoTag'
Plugin 'bufkill.vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-fugitive'
if v:version >= 704
  Plugin 'SirVer/ultisnips'
  Plugin 'honza/vim-snippets'
endif
Plugin 'ervandew/supertab'
Plugin 'drn/zoomwin-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"Display settings
set splitright
" set terminal 256 color version
set t_Co=16
" colorscheme settings
colorscheme darkblue
"Needed to preserve background color
set t_ut=
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
"Default vertical separator
set fillchars+=vert:│

"enabe project specified vimrc files
set exrc

"Disable swap file
set noswapfile

"When next buffer is opened the currently modified one goes into background
set hidden

"Enable exit/write confirmation 
"
set confirm
set relativenumber
set number

"Tag file names vim searches in current directory and up until it finds it
set tags=./tags;/

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
nnoremap <leader>/ :vimgrep //gj ./**/*.[ch] <Bar> cw <c-f>$T/;;;i
cnoremap <c-g> <CR>n/<c-p>
"Map key for quicksearch in project
map <F5> :execute "vimgrep /" . expand("<cword>") . "/gj ./**/*.[ch]" <Bar> cw<CR>

" start wildcard expansion in command mode
set wildchar=<Tab> wildmenu wildmode=longest,list
set wildignore+=*.so,*.swp,*.zip     " MacOSX/Linux

"allow backspace to remove neline and indentation in insert mode
set backspace=indent,eol,start

" ctrl-p options
let g:ctrlp_map = '<c-p>'
" start ctrl-p in file mode
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']
let g:ctrlp_custom_ignore = { 
      \'dir':  '\v[\/]\.(git|hg|svn)$',
      \'file': '\v\.(o|disasm|hex|readelf|ioc|bin|exe|so|dll)$'
      \}
" set working path as the current directory
let g:ctrlp_working_path_mode = 'a'
nnoremap <leader>b :CtrlPBufTag<CR>
nnoremap <leader>a :CtrlPTag<CR>
nnoremap <leader>t :CtrlPBuffer<CR>
nnoremap <leader>m :CtrlPMRU<CR>

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
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


" syntastic configuration
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {           
      \ "mode": "passive",             
      \ "active_filetypes": ["python"],
      \ "passive_filetypes": [] }      
let g:syntastic_c_checkers=['make']
"Syntastic mapping 
nnoremap <silent> <leader>sc :SyntasticCheck <CR>
nnoremap <silent> <leader>sr :SyntasticReset <CR>
nnoremap <silent> <leader>st :SyntasticToggleMode <CR>


"ZoomWin mapping
nnoremap <silent> <C-w>w :ZoomWin<CR>

"Enabled extended tabline 
let g:airline#extensions#tabline#enabled = 1

"Autoformatter options
let g:formatdef_my_custom_c = '"astyle -A7 --mode=c -pcHs".&shiftwidth'
let g:formatters_c = ['my_custom_c']

"Autoformatter mapping
nmap <leader>af :Autoformat<CR>

"Autocomplete options
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>" 
imap <c-n> <C-X><C-O>
let g:SuperTabDefaultCompletionType = "context" 
set completeopt=longest,menuone 
set completeopt-=preview

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
"Faster and smoother movement
nnoremap <c-y> 3<c-y>
nnoremap <c-e> 3<c-e>
map <leader>- -
