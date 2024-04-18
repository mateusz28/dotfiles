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
      winopts = { preview = { hidden = "hidden" } },
    })
    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<C-T>", "<cmd>Files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>ah", "<cmd>History<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>ag", "<cmd>Rg<cr><cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>as", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ab", "<cmd>Buffers<cr>", { desc = "Find in opened buffers" })
    keymap.set("n", "<leader>a?", "<cmd>Helptags<cr>", { desc = "Find in help tags" })
    keymap.set("n", "<leader>ak", "<cmd>Fzf keymaps<cr>", { desc = "Find in key maps" })
    keymap.set("n", "<C-G>", "<cmd>Fzf git_files<cr>", { desc = "Find in git files" })
    keymap.set("n", "<leader>al", "<cmd>Fzf lsp_references<cr>", { desc = "Find in lsp references" })
    keymap.set("n", "<leader>ar", "<cmd>Fzf resume<cr>", { desc = "Find in lsp references" })
    keymap.set("n", "<leader>ac", "<cmd>Fzf colorschemes<cr>", { desc = "Change colorscheme" })
  end,
}
