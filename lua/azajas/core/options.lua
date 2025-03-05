local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = true -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
local output = vim.fn.system({ "tmux", "show-environment", "-g", "THEME" })
local background = "dark"
if output == "THEME=light\n" then
	background = "light"
end
opt.background = background -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
-- opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- undodir
local backups_path = vim.fn.expand("$HOME/.vim/backups")
vim.cmd("silent !mkdir" .. backups_path .. "  > /dev/null 2>&1")
opt.undodir = backups_path
opt.undofile = true

-- ask when closing buffer
opt.confirm = true

-- case insensitive search
opt.hlsearch = true
opt.ignorecase = true
opt.incsearch = true

-- enabe project specified vimrc files
opt.exrc = true

-- list white characters
opt.listchars = "tab:▏ ,trail:￮,multispace: ,lead: ,extends:▶,precedes:◀,nbsp:‿"
vim.cmd([[match ErrorMsg /\s\+$/]])

-- default width to mark with colorcolumn
vim.g.default_colorcolumn = "80"

vim.api.nvim_create_autocmd("FileType", {
	command = "set formatoptions-=cro",
})

if os.getenv("theme") == "light" then
	vim.o.background = "light"
end
