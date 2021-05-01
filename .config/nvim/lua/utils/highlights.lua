
local fn = vim.fn
local synIDattr = fn.synIDattr
local hlID = fn.hlID

local M = {}

--- Check if the current window has a winhighlight
function M.has_win_highlight(win_id, ...)
  local win_hl = vim.wo[win_id].winhighlight
  local has_match = false
  for _, target in ipairs({...}) do
    if win_hl:match(target) ~= nil then
      has_match = true
      break
    end
  end
  return (win_hl ~= nil and has_match), win_hl
end

--- TODO eventually move to using `nvim_set_hl`
function M.highlight(name, opts)
  local force = opts.force or false
  if name and vim.tbl_count(opts) > 0 then
    if opts.link and opts.link ~= "" then
      vim.cmd("highlight" .. (force and "!" or "") .. " link " .. name .. " " .. opts.link)
    else
      local cmd = {"highlight", name}
      if opts.guifg and opts.guifg ~= "" then
        table.insert(cmd, "guifg=" .. opts.guifg)
      end
      if opts.guibg and opts.guibg ~= "" then
        table.insert(cmd, "guibg=" .. opts.guibg)
      end
      if opts.gui and opts.gui ~= "" then
        table.insert(cmd, "gui=" .. opts.gui)
      end
      if opts.guisp and opts.guisp ~= "" then
        table.insert(cmd, "guisp=" .. opts.guisp)
      end
      if opts.cterm and opts.cterm ~= "" then
        table.insert(cmd, "cterm=" .. opts.cterm)
      end
      vim.cmd(table.concat(cmd, " "))
    end
  end
end

function M.hl_value(grp, attr)
  return synIDattr(hlID(grp), attr)
end

function M.all(hls)
  for _, hl in ipairs(hls) do
    M.highlight(unpack(hl))
  end
end

function M.general_overrides()
  M.all {
    {"Comment", {gui = "italic"}},
    --Neogit
    {"DiffAdd", {guibg = _G.P.bg, guifg = _G.P.green}},
    {"DiffDelete", {guibg = _G.P.bg, guifg = _G.P.red}},
    {"DiffChange", {guibg = _G.P.bg, guifg = _G.P.orange }},
    {"NeogitNotificationError", {link = "StError"}},
    {"NeogitNotificationWarning", {link = "StWarning"}},
    -- Git Signs
    {"GitSignsAdd", { guifg = _G.P.green}},
    {"GitSignsChange", {guifg = _G.P.orange}},
    {"GitSignsDelete", {guifg = _G.P.red}},
    --NvimTree
    {"NvimTreeNormal", {guibg = _G.P.bg }},
    {"NvimtreeVertSplit", {guibg = _G.P.bg, guifg = _G.P.bg}},
    {"NvimtreeStatusLine", {guibg = _G.P.bg, guifg = _G.P.white}},
    {"NvimtreeStatuslineNC", {guibg = _G.P.bg, guifg = _G.P.fg}},
    {"NvimTreeFolderIcon", {guifg = _G.P.blue}},
    {"NvimTreeIndentMarker", {guifg = _G.P.blue}},
    {"NvimTreeEmptyFolderName", {guifg = _G.P.white}},
    {"NvimTreeOpenedFolderName", {guifg = _G.P.blue}},
    {"NvimTreeGitDirty", {guifg = _G.P.light_yellow}},
  }
end

require("utils.autocommands").augroup(
  "ExplorerHighlights",
  {
    {
      events = {"VimEnter", "ColorScheme"},
      targets = {"*"},
      command = "lua require('utils.highlights').general_overrides()"
    }
  }
)

return M
