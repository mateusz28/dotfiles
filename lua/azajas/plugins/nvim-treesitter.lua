return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require("nvim-treesitter.configs")

      -- configure treesitter
      treesitter.setup({ -- enable syntax highlighting
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          disable = function(lang, buf)
            local ft = vim.api.nvim_buf_get_option(buf, "filetype")
            local disabled_fts = { "help", "dashboard", "alpha", "NvimTree", "neo-tree", "Trouble", "lazy", "mason", "toggleterm", "markdown" }
            return vim.tbl_contains(disabled_fts, ft)
          end,
        },
        -- enable indentation
        indent = {
          enable = false,
          disable = { "python", "yaml" },
        },
        -- enable autotagging (w/ nvim-ts-autotag plugin)
        autotag = {
          enable = true,
        },
        -- ensure these language parsers are installed
        ensure_installed = {
          "c",
          "cpp",
          "java",
          "go",
          "objc",
          "cmake",
          "python",
          "make",
          "json",
          "javascript",
          "yaml",
          "markdown",
          "bash",
          "lua",
          "vim",
          "vimdoc",
          "luadoc",
          "dockerfile",
          "gitignore",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })

    end,
  },
}
