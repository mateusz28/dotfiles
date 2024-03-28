return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = { "BufReadPre", "BufNewFile" },
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    },
    config = function()
      require("CopilotChat").setup({})
      -- Show help actions with telescope
      vim.keymap.set("n", "<leader>ch", function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.telescope").pick(actions.help_actions())
      end, { desc = "CopilotChat - Help actions" })
      -- Show prompts actions with fzf-lua
      vim.keymap.set("n", "<leader>cp", function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
      end, { desc = "CopilotChat - Prompt actions" })
      vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChat<cr>",
        { desc = "CopilotChat - Open windows" })
    end,
  },
}
