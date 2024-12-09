return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = { "BufReadPre", "BufNewFile" },
    branch = "main",
    dependencies = {
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    },
    config = function()
      require("CopilotChat").setup({
        window = {
          layout = "horizontal",
        },
        context = nil,
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
          Tags = {
            prompt = "Create 8 short tags describing the following code. At the end list them as comma separated list starting with TAGS:",
            description = "Creates 8 tags for the code",
            selection = require("CopilotChat.select").buffer,
          },
        },
      })
      -- Show help actions with telescope
      vim.keymap.set("n", "<leader>cf", ":CopilotChatFixDiagnostic<CR>", { desc = "CopilotChat - Help actions" })
      vim.keymap.set({ "n", "v" }, "<leader>ch", function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.fzflua").pick(actions.help_actions())
      end, { desc = "CopilotChat - Help actions" })
      -- Show prompts actions with fzf-lua
      vim.keymap.set({ "n", "v" }, "<leader>cp", function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.fzflua").pick(actions.prompt_actions())
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
