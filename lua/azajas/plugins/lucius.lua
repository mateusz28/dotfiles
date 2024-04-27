return {
  {
    "mateusz28/vim-lucius",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        --vim.cmd([[let g:lucius_no_term_bg = 1]])
        --vim.cmd([[colorscheme lucius]])
        --vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
    end,
  },
}
