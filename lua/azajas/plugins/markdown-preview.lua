-- install without yarn or npm
return {
  "iamcco/markdown-preview.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  config = function()
    vim.cmd([[let g:mkdp_auto_close=0]])
    vim.cmd([[let g:mkdp_refresh_slow=1]])
    vim.cmd([[let g:mkdp_markdown_css=printf('%s/dotfiles/markdown-css/markdown.css', $HOME)]])
    vim.cmd([[let g:mkdp_page_title = '${name}']])
    vim.cmd([[let g:mkdp_theme = 'light']])
  end,
}
