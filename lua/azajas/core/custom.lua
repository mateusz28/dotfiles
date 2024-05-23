-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

local function adnote(note)
	local script_path = vim.fn.expand("$HOME/dotfiles/bin/vnote")
  local tags = function()
      local status, tag = pcall(function()
          return vim.fn.input({prompt = "# Note: "})
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
  return table.concat(lines, "\n")
end

-- Expose the function to the Vim scripting environment
_G.get_lines = get_lines
_G.adnote = adnote

-- Map the '<leader>an' keys to get the current line or a range of lines
keymap.set({"n", "v"}, "gan", function()
	_G.adnote(_G.get_lines(vim.v.count1))
end, { noremap = true, desc = "Add a note with the current line" })
