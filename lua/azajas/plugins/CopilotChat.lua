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
      require("CopilotChat").setup({
        prompts = {
          ImproveGrammarInStrings = {
            prompt = "Improve grammar, wording amd spelling in strings in selected code. If possible make it concise.",
            description = "Imprves grammar in help, error or other strings",
            selection = require("CopilotChat.select").visual,
          },
          Summarize = {
            prompt = "Please summarize the following text",
            description = "Writes a short summary.",
            selection = require("CopilotChat.select").visual,
          },
        },
      })
      -- Show help actions with telescope
      vim.keymap.set("n", "<leader>cf", ":CopilotChatFixDiagnostic<CR>", { desc = "CopilotChat - Help actions" })
      vim.keymap.set({ "n", "v" }, "<leader>ch", function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.telescope").pick(actions.help_actions())
      end, { desc = "CopilotChat - Help actions" })
      -- Show prompts actions with fzf-lua
      vim.keymap.set({ "n", "v" }, "<leader>cp", function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
      end, { desc = "CopilotChat - Prompt actions" })
      vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CopilotChatToggle<cr>", { desc = "CopilotChat - Open windows" })
      vim.keymap.set({ "n" }, "<leader>cq", function()
        local input = vim.fn.input("Quick Chat: ")
        if input ~= "" then
          require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
        end
      end, { desc = "CopilotChat - Quick chat" })
    end,
  },
}
