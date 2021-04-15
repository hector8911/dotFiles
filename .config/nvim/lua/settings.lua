local cmd = vim.cmd

--global options
local o = vim.o
--window-local options
local wo = vim.wo
--buffer-local options
local bo = vim.bo

local function add(value, str, sep)
  sep = sep or ","
  str = str or ""
  value = type(value) == "table" and table.concat(value, sep) or value
  return str ~= "" and table.concat({value, str}, sep) or value
end


-- List chars {{{1
-----------------------------------------------------------------------------//
vim.o.list = true -- invisible chars
vim.o.listchars =
  add {
  "eol: ",
  "tab:│ ",
  "extends:›", -- Alternatives: … »
  "precedes:‹", -- Alternatives: … «
  "trail:•" -- BULLET (U+2022, UTF-8: E2 80 A2)
}

o.mouse= 'a'
o.clipboard = 'unnamedplus'
o.termguicolors = true
o.syntax = 'enable'
vim.g.polyglot_disabled = {"sensible"}
cmd 'colorscheme monokai'
--cmd 'filetype plugin indent on'
o.fillchars =
  add {
  "vert:▕", -- alternatives │
  "fold: ",
  "eob: ", -- suppress ~ at EndOfBuffer
  "diff:░", -- alternatives: ⣿ ░
  "msgsep:‾",
  "foldopen:▾",
  "foldsep:│",
  "foldclose:▸"
}

o.hidden = true
o.scrolloff = 4
o.ignorecase = true
--o.showmatch = true
o.encoding = 'utf-8'
o.showmode = false
o.laststatus = 2
o.sw = 4
o.backup = false
o.swapfile = false
o.writebackup = false
o.showtabline = 2

wo.foldmethod = 'indent'
wo.foldenable = false
wo.foldlevel = 1

o.ruler = true

wo.nu = true
wo.rnu = true

--Indentation
bo.shiftwidth = 4
bo.tabstop = 4
bo.smartindent = true
bo.expandtab = true
bo.autoindent = true


--o.splitbelow = true
--o.splitright = true
--o.eadirection = "hor"

--Dir Snippets
vim.g.vsnip_snippet_dir = "~/.config/nvim/my-snippets"

o.emoji = false
