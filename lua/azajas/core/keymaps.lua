-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------
keymap.set("n", "<leader>tl", ":set list!<CR>", { desc = "Toggle list characters" })
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
keymap.set("n", "<leader>tb", function()
	if vim.o.background == "dark" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end
	print("Background: " .. tostring(vim.o.background))
end, { desc = "Toggle background theme" })
vim.keymap.set("n", "<leader>td", function()
	local diagnostics_enabled = not vim.diagnostic.is_enabled()
	vim.diagnostic.enable(diagnostics_enabled)
	print("Diagnostics enabled: " .. tostring(diagnostics_enabled))
end, { silent = true, noremap = true, desc = "Toggle diagnosticts" })

keymap.set("c", "<C-a>", "<Home>", { desc = "Control a returns to home in cmd" }) --  move current buffer to new tab
