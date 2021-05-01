
--global options
local o = vim.o
--window-local options
local wo = vim.wo

o.completeopt = "menuone,noselect"
o.mouse= 'a'
o.clipboard = 'unnamedplus'
o.termguicolors = true
o.syntax = 'enable'
vim.g.polyglot_disabled = {"sensible"}
vim.cmd 'colorscheme monokai'
--o.fillchars = "eob: "

o.hidden = true
o.scrolloff = 4
o.ignorecase = true
o.encoding = 'utf-8'
o.showmode = false
o.laststatus = 2
o.backup = false
o.swapfile = false
o.writebackup = false
o.showtabline = 2

wo.foldmethod = 'expr'
wo.foldexpr = 'nvim_treesitter#foldexpr()'
wo.foldenable = false
--wo.foldlevel = 1

wo.nu = true
wo.rnu = true

--Indentation
o.sw = 2
o.ts = 2
o.si = true
o.et = true

--Dir Snippets
vim.g.vsnip_snippet_dir = "~/.config/nvim/my-snippets"

o.emoji = false

o.shortmess =
  table.concat(
  {
    --"A", -- ignore annoying swap file messages
    "t", -- truncate file messages at start
    --"o", -- file-read message overwrites previous
    --"O", -- file-read message overwrites previous
    --"T", -- truncate non-file messages in middle
    --"f", -- (file x of x) instead of just (x of x

    "F", -- Don't give file info when editing a file, NOTE: this breaks autocommand messages
    --"s",
    "c",
    "W" -- Dont show [w] or written when writing
  }
)

o.guicursor = "n-v-sm:block,i-ci-ve-c:ver25,r-cr-o:hor20"
