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
Plugin 'terryma/vim-multiple-cursors'
Plugin 'easymotion/vim-easymotion'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Chiel92/vim-autoformat'
Plugin 'bling/vim-airline'
Plugin 'ervandew/supertab'
Plugin 'matze/vim-move'
Plugin 'vim-scripts/AutoTag'
Plugin 'bufkill.vim'
" Track the engine.
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
"Plugin 'camelcasemotion'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set splitright
set t_Co=256
colorscheme gruvbox
:set background=dark
set t_ut=
let g:statline_syntastic = 0
" Press F7 to toggle highlighting on/off, and show current value.
" remap <silent> <Leader>+ :exe "resize " . (winwidth(0) * 11/10)
" remap <silent> <Leader>+ :exe "resize " . (winwidth(0) * 9/10)
noremap <F7> :set hlsearch! hlsearch?<CR>
noremap <F2> :NERDTreeToggle<CR>
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
no <left> <Nop>
no <up> <Nop>
no <right> <Nop>
no <down> <Nop>
set wildchar=<Tab> wildmenu wildmode=full
set wildcharm=<C-Z>
nnoremap <F10> :b <C-Z>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

set backspace=indent,eol,start
filetype plugin on

"let g:ctrlp_custom_ignore = {\
"   'dir':  '\v[\/]\.(git|hg|svn)$',\
"   'file': '\v\.(bin|exe|so|dll)$',\
"   'link': 'some_bad_symbolic_links',\
"   }

let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']
let g:ctrlp_custom_ignore = { 'dir':  '\v[\/]\.(git|hg|svn)$', 'file': '\v\.(o|disasm|hex|readelf|ioc|bin|exe|so|dll)$'}
let g:ctrlp_working_path_mode = 'wr'
"let g:ctrlp_user_command = 'find %s -name *.[ch] -o -name *.mk -o -name Makefile -o -name *.ld -o -name *.sh -o -name *.sym -o -name *.readelf -type f'
let g:NERDTreeChDirMode       = 2


" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsListSnippets="<c-v>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set relativenumber
set number

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'passive_filetypes': ['c'] }

set autoindent
set cindent
set tabstop=2 shiftwidth=2 expandtab
set number

syntax on

let g:formatdef_my_custom_c = '"astyle -A7 --mode=c -pcHs".&shiftwidth'
let g:formatters_c = ['my_custom_c']

let mapleader = "-"
nmap <leader>ne :NERDTreeToggle<CR>
nmap <leader>af :Autoformat<CR>

function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
  call DelTagOfFile(f)
  let resp = system(cmd)
endfunction
autocmd BufWritePost *.cpp,*.h,*.c call UpdateTags()


function! s:DiffWithSVNCheckedOut()
  if exists('b:svndiffflag')
    "let b:svndiffflag = 0
    exe "diffoff"
    exe "q"
    exe "bd | e#"
  else
    let filetype=&ft
    diffthis
    let x = expand('%:p')
    let y =substitute(x,"#","\\\\#","g")
    echo y
    vnew | exe "%!svn cat " . y
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
    let b:svndiffflag = 1
  endif
endfunction
com! DiffSVN call s:DiffWithSVNCheckedOut()

set tags=./tags;/
set laststatus=2
let g:airline#extensions#tabline#enabled = 1

"nmap <CR><CR> O<Esc>
"nmap <CR> o<Esc>

nnoremap <F3> :Autoformat<CR>


function! GetVisualSelection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

map <F5> :execute "vimgrep /" . expand("<cword>") . "/gj ./**/*.[ch]" <Bar> cw<CR>
"map <F6> :execute "vimgrep /" . call GetVisualSelection()  . "/gj ./**/*.[ch]" <Bar> cw<CR>
" :vimgrep /word/gj ./**/*.c | cw
map <F9> :DiffSVN<CR>

set hidden
set confirm
set t_Co=256
let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }
let g:multi_cursor_exit_from_visual_mode=0

set fillchars+=vert:│
"hi! VertSplit ctermfg=fg ctermbg=bg term=NONE

set ignorecase
set incsearch

nnoremap <Leader>[ :bp<CR>
nnoremap <Leader>] :bn<CR>
vnoremap // y/<C-R>"<CR>
nnoremap <leader>b :CtrlPBufTag<CR>
nnoremap <leader>a :CtrlPTag<CR>
nnoremap <leader>t :CtrlPBuffer<CR>
nnoremap <Leader>/ :vimgrep //gj ./**/*.c <Bar> cw <c-f>$T/;;;i
nnoremap <Leader>o mao<Esc>`a
nnoremap <Leader>O maO<Esc>`a
nnoremap <c-]> <c-]>z.
nnoremap <c-y> 3<c-y>
nnoremap <c-e> 3<c-e>
"nnoremap / /\c
"nnoremap ? ?\c
filetype plugin on
set omnifunc=syntaxcomplete#Complete
"set clipboard=unnamedplus
let g:SuperTabDefaultCompletionType = "context"
set completeopt-=preview
set completeopt+=longest
let g:SuperTabLongestHighlight = 1 

let g:move_key_modifier = 'C'
