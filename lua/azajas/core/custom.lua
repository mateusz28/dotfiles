-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

local function adnote(note)
	local script_path = vim.fn.expand("$HOME/dotfiles/bin/vnote")
	local tags = function()
		local status, tag = pcall(function()
			return vim.fn.input({ prompt = "# Note: " })
		end)

		if status then
			return (tag and tag ~= "") and tag or ""
		else
			return "Empty"
		end
	end
	local tags_str = tags()
	local type = vim.bo.filetype
	vim.fn.system({
		script_path,
		type,
		tags_str,
		note,
	})
end

local function get_lines(count)
	local start = vim.api.nvim_win_get_cursor(0)[1]
	local stop = start + count - 1
	local lines = vim.fn.getline(start, stop)
	if type(lines) == "string" then
		lines = { lines }
	end
	return table.concat(lines, "\n")
end

-- Expose the function to the Vim scripting environment
_G.get_lines = get_lines
_G.adnote = adnote

-- Map the '<leader>an' keys to get the current line or a range of lines
keymap.set({ "n", "v" }, "gan", function()
	_G.adnote(_G.get_lines(vim.v.count1))
end, { noremap = true, desc = "Add a note with the current line" })

-- Open current note
local function open_notes()
	-- Get the hostname
	local handle = io.popen("hostname")
	if not handle then
		return
	end
	local hostname = handle:read("*a"):gsub("%s+", "")
	handle:close()

	-- Construct the filename
	local notes_name = os.date("notes_%Y-%m-%d_" .. hostname .. ".md")

	-- Change directory to $HOME/notes
	vim.cmd("lcd " .. os.getenv("HOME") .. "/notes")

	-- Open the file in a vertical split
	vim.cmd("vsplit " .. notes_name)
end

-- Map the function to a key combination
vim.keymap.set("n", "<leader>tc", open_notes, { silent = true, noremap = true, desc = "Open notes" })
