-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
keymap.set("n", "<leader>tl", "<cmd>set background=light<CR>", { desc = "Chenge theme to light" }) --  move current buffer to new tab
keymap.set("n", "<leader>td", "<cmd>set background=dark<CR>", { desc = "Change theme to dark" }) --  move current buffer to new tab

keymap.set("c", "<C-a>", "<Home>", { desc = "Control a returns to home in cmd" }) --  move current buffer to new tab
