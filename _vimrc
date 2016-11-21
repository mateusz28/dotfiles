" source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim
" behave mswin


set nocompatible              " be iMproved, required
filetype off                  " required



" set the runtime path to include Vundle and initialize
set rtp+=$VIM/vimfiles/bundle/Vundle.vim/
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Chiel92/vim-autoformat'
Plugin 'bling/vim-airline'
Plugin 'matze/vim-move'
Plugin 'vim-scripts/AutoTag'
Plugin 'bufkill.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'ervandew/supertab'
Plugin 'drn/zoomwin-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"Display settings
if !has("gui_running")
  set term=xterm
  set t_Co=256
  let &t_AB="\e[48;5;%dm"
  let &t_AF="\e[38;5;%dm"
  colorscheme lucius
  LuciusBlack
endif
set splitright
" set terminal 256 color version
" colorscheme settings
"Needed to preserve background color
set t_ut=
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
" column coloring facility
set colorcolumn=110
highlight ColorColumn ctermbg=darkgray
"Default vertical separator

"enabe project specified vimrc files
set exrc

"When next buffer is opened the currently modified one goes into background
set hidden

"Enable exit/write confirmation
set confirm

"Set - as default leader character
let mapleader = "-"
"Search options
" Press F7 to toggle highlighting on/off, and show current value.
noremap <F7> :set hlsearch! hlsearch?<CR>
set ignorecase
set incsearch
nnoremap <Leader>/ :vimgrep //gj ./**/*.c <Bar> cw <c-f>$T/;;;i
nnoremap <leader>/ :vimgrep //gj ./**/*.c <Bar> cw <c-f>$T/;;;i
cnoremap <c-g> <CR>n/<c-p>
nnoremap <n> <n>z.
nnoremap <N> <N>z.
"Map key for quicksearch in project
map <F5> :execute "vimgrep /" . expand("<cword>") . "/gj ./**/*.[ch]" <Bar> cw<CR>

" turn of arrows in normal mode
no <left> <Nop>
no <up> <Nop>
no <right> <Nop>
no <down> <Nop>

" start wildcard expansion in command mode
set wildchar=<Tab> wildmenu wildmode=full
" same as abowe but recognized in a macro
set wildcharm=<C-Z>
set wildignore+=*.so,*.swp,*.zip     " MacOSX/Linux

"allow backspace to remove neline and indentation in insert mode
set backspace=indent,eol,start
"fix backspace
inoremap <Char-0x07F> <BS>
nnoremap <Char-0x07F> <BS>
vnoremap <Char-0x07F> <BS>
map! <Char-0x07F> <BS>
let g:ctrlp_prompt_mappings = {'PrtBS()': ['<Char-0x07F>']}
"Vim move options
let g:move_key_modifier = 'C'

" ctrl-p options
let g:ctrlp_map = '<c-p>'
" start ctrl-p in file mode
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']
let g:ctrlp_custom_ignore = {
      \'dir':  '\v[\/]\.(git|hg|svn)$',
      \'file': '\v\.(o|disasm|hex|readelf|ioc|bin|exe|so|dll)$'
      \}
" set working path as the first ancestor with subversion file
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

" relative line numeration
set relativenumber
set number

"Tag file names vim searches in current directory and up until it finds it
set tags=./tags;/

" syntastic configuration
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'passive_filetypes': ['c'] }
let g:syntastic_c_checkers=['make']
"Syntastic mapping
nnoremap <silent> <leader>sc :SyntasticCheck <CR>
nnoremap <silent> <leader>sr :SyntasticReset <CR>
nnoremap <silent> <leader>st :SyntasticToggleMode <CR>

"Syntax highlighting
syntax on

"ZoomWin mapping
nnoremap <silent> <C-w>w :ZoomWin<CR>

"Default indentation settings
set autoindent
set cindent
set tabstop=2 shiftwidth=2 expandtab
"Always show status bar
set laststatus=2
"Enabled extended tabline
let g:airline#extensions#tabline#enabled = 1

"Disable swap file
set noswapfile

"Autoformatter options
let g:formatdef_my_custom_c = '"astyle -A7 --mode=c -pcHs".&shiftwidth'
let g:formatters_c = ['my_custom_c']

"Autoformatter mapping
nmap <leader>af :Autoformat<CR>
nnoremap <F3> :Autoformat<CR>

"Vim custom scripts
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
map <F9> :DiffSVN<CR>

function! s:DiffWithSaved()
  if exists('b:savediffflag')
    exe "diffoff"
    exe "q"
    exe "bd | e#"
  else
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
    let b:savediffflag = 1
  endif
endfunction
com! DiffSaved call s:DiffWithSaved()
map <F10> :DiffSaved<CR>

function! GetVisualSelection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

"Autocomplete options
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
imap <c-n> <C-X><C-O>
let g:SuperTabDefaultCompletionType = "context"
set completeopt=longest,menuone
set completeopt-=preview

"Additional mapping
"Paste mode togglig for copying big parts of files
nnoremap <Leader>p :set invpaste paste? <CR>
"Buffer movement
nnoremap <Leader>[ :bp<CR>
nnoremap <Leader>] :bn<CR>
"Repeat search
vnoremap // y/<C-R>"<CR>
"Newline without exiting normal mode
nnoremap <Leader>o mao<Esc>`a
nnoremap <Leader>O maO<Esc>`a
"Center after jump
nnoremap <c-]> <c-]>z.
nnoremap <c-o> <c-o>z.
nnoremap <c-i> <c-i>z.
"Faster and smoother movement
nnoremap <c-y> 3<c-y>
nnoremap <c-e> 3<c-e>
