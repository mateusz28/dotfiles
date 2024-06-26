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
" Plug 'junegunn/fzf.vim'
Plug 'rbong/galvanize.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }
"Plug 'codota/tabnine-nvim', { 'do': './dl_binaries.sh' }
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'neoclide/coc-snippets'
Plug 'NLKNguyen/papercolor-theme'
Plug 'vim-airline/vim-airline-themes'
Plug 'aklt/plantuml-syntax'
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'tyru/open-browser.vim'
Plug 'godlygeek/tabular' | Plug 'tpope/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
":Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'zbirenbaum/copilot.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'canary' }
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
" optional for icon support
Plug 'nvim-tree/nvim-web-devicons'

call plug#end()            " required

"Display settings
set splitright
" set terminal 256 color version
set t_Co=256
" colorscheme settings
set background=dark
"colorscheme PaperColor
"let g:airline_theme='papercolor'
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
let mapleader = " "
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

""Snippets options
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"let g:UltiSnipsListSnippets="<c-v>"

" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"

" statusline options
set statusline+=%#warningmsg#
set statusline+=%*

"Enabled extended tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = "dark"

"Autoformatter options
let g:formatdef_my_custom_c = '"astyle -A7 --mode=c -pcHs".&shiftwidth'
let g:formatters_c = ['my_custom_c']

"Autoformatter mapping
nmap <leader>af :Autoformat<CR>

set completeopt-=preview


" Fzf options
let g:fzf_history_dir = '~/.local/share/fzf-history'
" Customize fzf colors to match your color scheme
"let g:fzf_colors =
"\ { 'fg':      ['fg', 'Normal'],
"  \ 'bg':      ['bg', 'Normal'],
"  \ 'hl':      ['fg', 'Comment'],
"  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"  \ 'hl+':     ['fg', 'Statement'],
"  \ 'info':    ['fg', 'PreProc'],
"  \ 'border':  ['fg', 'Ignore'],
"  \ 'prompt':  ['fg', 'Conditional'],
"  \ 'pointer': ['fg', 'Exception'],
"  \ 'marker':  ['fg', 'Keyword'],
"  \ 'spinner': ['fg', 'Label'],
"  \ 'header':  ['fg', 'Comment'] }
"
set updatetime=100

let g:openbrowser_browser_commands = [
\   {'name': '/usr/bin/brave',
\    'args': ['{browser}', '{uri}']}
\]


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
nnoremap <Leader>ag :Rg<CR><CR>
nnoremap <Leader>rg :Rg<CR><CR>
nnoremap <Leader>at :Tags<CR>
nnoremap <Leader>ab :Buffers<CR>
nnoremap <Leader>ah :History<CR>

"Faster and smoother movement
nnoremap <c-y> 3<c-y>
nnoremap <c-e> 3<c-e>
nmap <leader>gs :Git<CR>
nmap <leader>gd :Gdiff<CR>
nnoremap Q <Nop>
map <leader>- -
cnoremap <C-A> <Home>

let g:mkdp_auto_close=0
let g:mkdp_refresh_slow=1
let g:mkdp_markdown_css=printf('%s/dotfiles/markdown-css/markdown.css', $HOME)
let g:mkdp_page_title = '${name}'
let g:mkdp_theme = 'light'

autocmd VimResized * wincmd =
inoremap <C-v> <C-r>+
xnoremap Q :'<,'>:normal @q<CR>
xnoremap . :norm.<CR>
autocmd FileType * set formatoptions-=cro
" Vim gutter
nmap ghp <Plug>(GitGutterPreviewHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap <Leader>t :source ~/dotfiles/.nvimrc<CR>
" command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
func! GutterSetBase(entry)
  let g:gitgutter_diff_base = a:entry
  GitGutterAll
endfunc
nnoremap <leader>ad :call  fzf#run(fzf#wrap({'source': 'git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"', 'sink': function('GutterSetBase'), 'options':'--ansi  --bind "ctrl-m:become(echo {1})"'}))<CR>

"lua <<EOF
"require('tabnine').setup({
"  disable_auto_comment=true,
"  accept_keymap="<Tab>",
"  dismiss_keymap = "<C-]>",
"  debounce_ms = 800,
"  suggestion_color = {gui = "#808080", cterm = 244},
"  exclude_filetypes = {"TelescopePrompt"},
"  log_file_path = nil, -- absolute path to Tabnine log file
"})
"EOF
lua << EOF
require("fzf-lua").setup({ "fzf-vim" })
require("copilot").setup({
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
    layout = {
      position = "bottom", -- | top | left | right
      ratio = 0.4
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = false,
    debounce = 75,
    keymap = {
      accept = "<M-l>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = 'node', -- Node.js version must be > 18.x
  server_opts_overrides = {},
})
require("CopilotChat").setup {
  debug = true, -- Enable debugging
  -- lazy.nvim keys
  -- Show help actions with fzf-lua
  -- See Configuration section for rest
}
EOF
