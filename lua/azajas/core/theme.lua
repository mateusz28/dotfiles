local M = {}

local function detect_theme()
  local output = vim.fn.system({ "tmux", "show-environment", "-g", "THEME" })
  if output == "THEME=light\n" or os.getenv("theme") == "light" then
    return "light"
  end
  return "dark"
end

M.background = detect_theme()
M.is_light = (M.background == "light")

return M
