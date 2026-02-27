return {
  "rmagatti/auto-session",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  config = function()
    local auto_session = require("auto-session")

    local function refresh_lsp_for_restored_buffers()
      vim.defer_fn(function()
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].buftype == "" then
            local name = vim.api.nvim_buf_get_name(bufnr)
            if name ~= "" and vim.bo[bufnr].filetype == "" then
              vim.api.nvim_buf_call(bufnr, function()
                vim.cmd("silent! filetype detect")
              end)
            end
            vim.api.nvim_exec_autocmds("FileType", {
              group = "nvim.lsp.enable",
              buffer = bufnr,
              modeline = false,
            })
          end
        end
      end, 50)
    end

    auto_session.setup({
      auto_restore = true,
      auto_save = true,
      suppressed_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
      post_restore_cmds = {
        refresh_lsp_for_restored_buffers,
      },
    })

    local keymap = vim.keymap

    keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
    keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
  end,
}
