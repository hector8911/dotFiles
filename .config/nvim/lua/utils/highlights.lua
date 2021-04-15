local fn = vim.fn
local synIDattr = fn.synIDattr
local hlID = fn.hlID

local P = require("utils.colors").palette

local M = {}

--- Check if the current window has a winhighlight
--- which includes the specific target highlight
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

local function find(haystack, matcher)
  local found
  for _, needle in ipairs(haystack) do
    if matcher(needle) then
      found = needle
      break
    end
  end
  return found
end

---A mechanism to allow inheritance of the winhighlight of a specific
function M.adopt_winhighlight(win_id, target, name, default)
  name = name .. win_id
  local _, win_hl = M.has_win_highlight(win_id, target)
  local hl_exists = vim.fn.hlexists(name) > 0
  if not hl_exists then
    local parts = vim.split(win_hl, ",")
    local found =
      find(
      parts,
      function(part)
        return part:match(target)
      end
    )
    if found then
      --[[local hl_group = vim.split(found, ":")[2]
      local bg = M.hl_value(hl_group, "bg")
      local fg = M.hl_value(default, "fg")
      local gui = M.hl_value(default, "gui")
      M.highlight(name, {guibg = P.dark, guifg = P.white, gui = gui})]]
    end
  end
  return name
end

--- TODO eventually move to using `nvim_set_hl`
--- however for the time being that expects colors
--- to be specified as rgb not hex
---@param name string
---@param opts table
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

local function general_overrides()
  M.all {
    {"Comment", {gui = "italic"}},
    -- Customize Diff highlighting, Neogit
    {"DiffAdd", {guibg = P.bg, guifg = P.green}},
    {"DiffDelete", {guibg = P.bg, guifg = P.red}},
    {"DiffChange", {guibg = P.bg, guifg = P.orange }},
    -- Git Signs
    {"GitSignsAdd", { guifg = P.green}},
    {"GitSignsChange", {guifg = P.orange}},
    {"GitSignsDelete", {guifg = P.red}},
  }
end

local function set_explorer_highlight()
  local hls = {
    {"ExplorerBackground", {guibg = P.bg }},
    {"ExplorerVertSplit", {guibg = P.bg, guifg = P.bg}},
    {"ExplorerSt", {guibg = P.bg, guifg = P.white}},
    --unfocus
    {"ExplorerStNC", {guibg = P.bg, guifg = P.fg}},
  }
  for _, grp in ipairs(hls) do
    M.highlight(unpack(grp))
  end
end

function M.on_explorer_enter()
  local highlights =
    table.concat(
    {
      "Normal:ExplorerBackground",
      "EndOfBuffer:ExplorerBackground",
      "StatusLine:ExplorerSt",
      "StatusLineNC:ExplorerStNC",
      "SignColumn:ExplorerBackground",
      "VertSplit:ExplorerVertSplit",
    },
    ","
  )
  vim.cmd("setlocal winhighlight=" .. highlights)
end

function M.apply_user_highlights()
  general_overrides()
  set_explorer_highlight()
end

require("utils.autocommands").augroup(
  "ExplorerHighlights",
  {
    {
      events = {"VimEnter", "ColorScheme"},
      targets = {"*"},
      command = "lua require('utils.highlights').apply_user_highlights()"
    },
    {
      events = {"FileType"},
      targets = {"NvimTree"},
      command = "lua require('utils.highlights').on_explorer_enter()"
    }
  }
)

return M
