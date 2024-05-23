return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "molecule-man/telescope-menufacture",
    "mollerhoj/telescope-recent-files.nvim",
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
    telescope.load_extension("recent-files")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set(
      "n",
      "<C-T>",
      require("telescope").extensions.menufacture.find_files,
      { desc = "Fuzzy find files in cwd" }
    )
    keymap.set("n", "<leader>ah", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set(
      "n",
      "<leader>as",
      require("telescope").extensions.menufacture.grep_string,
      { desc = "Find string under cursor in cwd" }
    )
    keymap.set(
      "n",
      "<leader>ag",
      require("telescope").extensions.menufacture.live_grep,
      { desc = "Find string in cwd" }
    )
    keymap.set("n", "<leader>ab", "<cmd>Telescope buffers<cr>", { desc = "Find in opened buffers" })
    keymap.set("n", "<leader>a?", "<cmd>Telescope help_tags<cr>", { desc = "Find in help tags" })
    keymap.set("n", "<leader>ak", "<cmd>Telescope keys<cr>", { desc = "Find in key maps" })
    keymap.set("n", "<C-G>", require("telescope").extensions.menufacture.git_files, { desc = "Find in git files" })
    keymap.set("n", "<leader>at", "<cmd>Telescope treesitter<cr>", { desc = "Find in tree sitter" })
    keymap.set("n", "<leader>al", "<cmd>Telescope lsp_references<cr>", { desc = "Find in lsp references" })
    keymap.set("n", "<leader>ac", "<cmd>Telescope colorscheme<cr>", { desc = "Change colorscheme" })
    keymap.set("n", "<leader>ar", "<cmd>Telescope resume<cr>", { desc = "Change resume" })
    keymap.set("n", "<leader>ad", "<cmd>Telescope diagnostics<cr>", { desc = "Change diagnostics" })
    keymap.set("n", "<leader>an", function()
      vim.loop.spawn("bash", {
        args = { "-c", "cd $HOME/notes && git pull origin main" },
        onexit = function(code, signal)
          if code ~= 0 then
            print("Git pull failed with exit code: ", code)
          end
        end,
      })
      vim.cmd("Telescope live_grep search_dirs=~/notes path_display='hidden' disable_coordinates='false'")
    end, { desc = "Find in notes" })
    vim.keymap.set("n", "<leader><leader>", function()
      require("telescope").extensions["recent-files"].recent_files({})
    end, { noremap = true, silent = true })
  end,
}
