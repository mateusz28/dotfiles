return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      pickers = {
        git_files = {
          recurse_submodules = true,
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<C-T>", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>ah", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>ag", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>as", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ab", "<cmd>Telescope buffers<cr>", { desc = "Find in opened buffers" })
    keymap.set("n", "<leader>a?", "<cmd>Telescope help_tags<cr>", { desc = "Find in help tags" })
    keymap.set("n", "<leader>ak", "<cmd>Telescope keys<cr>", { desc = "Find in key maps" })
    keymap.set("n", "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Find in git files" })
    keymap.set("n", "<leader>at", "<cmd>Telescope treesitter<cr>", { desc = "Find in tree sitter" })
    keymap.set("n", "<leader>at", "<cmd>Telescope treesitter<cr>", { desc = "Find in tree sitter" })
    keymap.set("n", "<leader>ar", "<cmd>Telescope lsp_references<cr>", { desc = "Find in lsp references" })
  end,
}
