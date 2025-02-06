local luasnip = require("luasnip")
local t = luasnip.text_node
local i = luasnip.insert_node
local s = luasnip.snippet
local d = luasnip.dynamic_node
local f = luasnip.function_node
local sn = luasnip.snippet_node
local fmta = require("luasnip.extras.fmt").fmta

local function generate_param_nodes(args, snip)
  local nodes = {}
  local func_signature = snip.env.SELECT_RAW and snip.env.SELECT_RAW[1] or ""
  local param_list = func_signature:match("%((.*)%)")
  if param_list then
    local index = 1
    for param in param_list:gmatch("[^,]+") do
      table.insert(nodes, t("* @param [in/out] " .. param:match("^%s*(.-)%s*$") .. " "))
      table.insert(nodes, i(index))
      table.insert(nodes, t("\n"))
      index = index + 1
    end
  end
  return sn(nil, nodes)
end

local function get_current_date()
  return os.date("%Y-%m-%d")
end

luasnip.add_snippets("all", {
  s(
    { trig = "comment", dscr = "Super advanced comment." },
    fmta(
      [[
      /******************************************************************************************************************//**
      * @briefly <>
      <>
      * @retval <>
      * @date <>
      * @author Mateusz Orzoł
      *********************************************************************************************************************/
      ]],
      {
        i(1),
        d(2, generate_param_nodes, {}),
        i(3),
        f(get_current_date, {}),
      }
    )
  ),
})

