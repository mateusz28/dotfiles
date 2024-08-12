return {
  "ibhagwan/fzf-lua",
  branch = "main",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("fzf-lua").setup({
      "fzf-vim",
      hls = {
        border = "No",
        preview_border = "No",
      },
      git = {
        files = {
          cmd = "git ls-files --exclude-standard --recurse-submodules",
        },
      },
      keymap = {
        -- Below are the default binds, setting any value in these tables will override
        -- the defaults, to inherit from the defaults change [1] from `false` to `true`
        builtin = {
          false, -- do not inherit from defaults
          -- neovim `:tmap` mappings for the fzf win
          ["<F1>"] = "toggle-help",
          ["<F2>"] = "toggle-fullscreen",
          -- Only valid with the 'builtin' previewer
          ["<F3>"] = "toggle-preview-wrap",
          ["?"] = "toggle-preview",
          -- Rotate preview clockwise/counter-clockwise
          ["<F5>"] = "toggle-preview-ccw",
          ["<F6>"] = "toggle-preview-cw",
          ["<S-down>"] = "preview-page-down",
          ["<S-up>"] = "preview-page-up",
          ["<S-left>"] = "preview-page-reset",
        },
        fzf = {
          false, -- do not inherit from defaults
          -- fzf '--bind=' options
          ["ctrl-z"] = "abort",
          ["ctrl-u"] = "unix-line-discard",
          ["ctrl-f"] = "half-page-down",
          ["ctrl-b"] = "half-page-up",
          ["ctrl-a"] = "beginning-of-line",
          ["ctrl-e"] = "end-of-line",
          ["alt-a"] = "toggle-all",
          -- Only valid with fzf previewers (bat/cat/git/etc)
          ["f3"] = "toggle-preview-wrap",
          ["f4"] = "toggle-preview",
          ["shift-down"] = "preview-page-down",
          ["shift-up"] = "preview-page-up",
        },
      },
      winopts = { preview = { hidden = "hidden" } },
    })
    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<C-T>", "<cmd>Files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader><leader>", "<cmd>Buffers<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>ah", "<cmd>History<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>ag", "<cmd>Rg<cr><cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>as", "<cmd>FzfLua grep_cword<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ab", "<cmd>Buffers<cr>", { desc = "Find in opened buffers" })
    keymap.set("n", "<leader>a?", "<cmd>Helptags<cr>", { desc = "Find in help tags" })
    keymap.set("n", "<leader>ak", "<cmd>Fzf keymaps<cr>", { desc = "Find in key maps" })
    keymap.set("n", "<C-G>", "<cmd>Fzf git_files<cr>", { desc = "Find in git files" })
    keymap.set("n", "<leader>al", "<cmd>Fzf lsp_references<cr>", { desc = "Find in lsp references" })
    keymap.set("n", "<leader>ar", "<cmd>Fzf resume<cr>", { desc = "Resume last search" })
    keymap.set("n", "<leader>ac", "<cmd>Fzf colorschemes<cr>", { desc = "Change colorscheme" })
    keymap.set("n", "<leader>ad", "<cmd>Fzf diagnostics_workspace<cr>", { desc = "Find in workspace diagnostics" })
  end,
}
