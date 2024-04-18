return {
  "mcchrish/zenbones.nvim",
  priority = 1000,
  dependencies = {
    { "rktjmp/lush.nvim" },
  },
  config = function()
    --vim.cmd([[let g:lucius_no_term_bg = 1]])
    --vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
    local zen_themes = {
      "kanagawabones",
      "randombones",
      "forestbones",
      "tokyobones",
      "seoulbones",
      "rosebones",
      "nordbones",
      "duckbones",
      "zenbones",
      "vimbones",
      "neobones",
    }
    for _, theme in ipairs(zen_themes) do
      vim.g[theme .. "_transparent_background"] = true
    end
    vim.cmd([[colorscheme forestbones]])
  end,
}
