return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count
    -- define a function that returns the total number of lines in the current buffer
    local function buffer_line_count()
      return tostring(vim.fn.line('$'))
    end

    -- configure lualine with modified theme
    lualine.setup({
      options = {
        theme = "auto",
      },
      sections = {
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
        lualine_y = {
          { "progress" },
          buffer_line_count, -- add the custom component here
        },
      },
      tabline = {
        lualine_a = { "tabs" },
        lualine_b = {
          {
            "filename",
            path = 3,
          },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
