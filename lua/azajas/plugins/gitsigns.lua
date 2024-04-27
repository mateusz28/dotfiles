return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local gitsigns = require("gitsigns")
    gitsigns.setup({
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]h", function()
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        map("n", "[h", function()
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        -- Actions
        map("n", "ghs", gs.stage_hunk, { desc = "Gitsigns stage hunk" })
        map("n", "ghr", gs.reset_hunk, { desc = "Gitsigns reset hunk" })
        map("v", "ghs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Gitsigns stage hunk" })
        map("v", "ghr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Gitsigns reset hunk" })
        map("n", "ghS", gs.stage_buffer, { desc = "Gitsigns stage buffer" })
        map("n", "ghu", gs.undo_stage_hunk, { desc = "Gitsigns undo stage hunk" })
        map("n", "ghR", gs.reset_buffer, { desc = "Gitsigns reset buffer" })
        map("n", "ghp", gs.preview_hunk, { desc = "Gitsigns preview hunk" })
        map("n", "ghb", function()
          gs.blame_line({ full = true })
        end, { desc = "Gitsigns blame line" })
        map("n", "gtb", gs.toggle_current_line_blame, { desc = "Gitsigns toggle current line blame" })
        map("n", "ghd", gs.diffthis, { desc = "Gitsigns diff this" })
        map("n", "ghD", function()
          gs.diffthis("~")
        end, { desc = "Gitsigns diff this" })
        map("n", "<leader>td", gs.toggle_deleted, { desc = "Gitsigns toggle deleted" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
    })
  end,
}
