return {
  {
    "GeorgesAlkhouri/nvim-aider",
    cmd = "Aider",
    -- Example key mappings for common actions:
    keys = {
      { "<leader>A/", "<cmd>Aider toggle<cr>", desc = "Toggle Aider" },
      { "<leader>As", "<cmd>Aider send<cr>", desc = "Send to Aider", mode = { "n", "v" } },
      { "<leader>Ac", "<cmd>Aider command<cr>", desc = "Aider Commands" },
      { "<leader>Ab", "<cmd>Aider buffer<cr>", desc = "Send Buffer" },
      { "<leader>A+", "<cmd>Aider add<cr>", desc = "Add File" },
      { "<leader>A-", "<cmd>Aider drop<cr>", desc = "Drop File" },
      { "<leader>Ar", "<cmd>Aider add readonly<cr>", desc = "Add Read-Only" },
      { "<leader>AR", "<cmd>Aider reset<cr>", desc = "Reset Session" },
      -- Example nvim-tree.lua integration if needed
      { "<leader>A+", "<cmd>AiderTreeAddFile<cr>", desc = "Add File from Tree to Aider", ft = "NvimTree" },
      { "<leader>A-", "<cmd>AiderTreeDropFile<cr>", desc = "Drop File from Tree from Aider", ft = "NvimTree" },
    },
    dependencies = {
      "folke/snacks.nvim",
      --- The below dependencies are optional
      -- "catppuccin/nvim",
      "nvim-tree/nvim-tree.lua",
      --- Neo-tree integration
      {
        "nvim-neo-tree/neo-tree.nvim",
        opts = function(_, opts)
          -- Example mapping configuration (already set by default)
          -- opts.window = {
          --   mappings = {
          --     ["+"] = { "nvim_aider_add", desc = "add to aider" },
          --     ["-"] = { "nvim_aider_drop", desc = "drop from aider" }
          --     ["="] = { "nvim_aider_add_read_only", desc = "add read-only to aider" }
          --   }
          -- }
          -- require("nvim_aider.neo_tree").setup(opts)
        end,
      },
    },
    config = function()
      -- Use theme module to determine if theme is light
      local theme = require("azajas.core.theme")
      local is_light = theme.is_light

      -- Build args dynamically
      local aider_args = {
        "--no-auto-commits",
        "--pretty",
        "--stream",
      }
      if is_light then
        table.insert(aider_args, "--light-mode")
      else 
        table.insert(aider_args, "--dark-mode")
      end

      require("nvim_aider").setup({
        -- Command that executes Aider
        aider_cmd = "aider",
        -- Command line arguments passed to aider
        args = aider_args,
        -- Automatically reload buffers changed by Aider (requires vim.o.autoread = true)
        auto_reload = true,
        -- Theme colors (automatically uses Catppuccin flavor if available)
        theme = {
          user_input_color = "#24273a",
          tool_output_color = "#8aadf4",
          tool_error_color = "#ed8796",
          tool_warning_color = "#eed49f",
          assistant_output_color = "#c6a0f6",
          completion_menu_color = "#cad3f5",
          completion_menu_bg_color = "#24273a",
          completion_menu_current_color = "#181926",
          completion_menu_current_bg_color = "#f4dbd6",
        },
        -- snacks.picker.layout.Config configuration
        picker_cfg = {
          preset = "vscode",
        },
        -- Other snacks.terminal.Opts options
        config = {
          os = { editPreset = "nvim-remote" },
          gui = { nerdFontsVersion = "3" },
        },
        win = {
          wo = { winbar = "Aider" },
          style = "nvim_aider",
          position = "right",
        },
      })
    end,
  },
}
