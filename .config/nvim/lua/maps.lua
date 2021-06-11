
local C = require('utils')
vim.g.mapleader = ' '

local opt = {noremap = true, silent = true}

-- Clear highlights
C.map('n', '<Esc>', '<cmd>noh<CR>')

-- Save and exit
C.map('n', '<leader>w', ':w<cr>', opt)
C.map('n', '<leader>q', ':q<cr>', opt)

-- Buffers
C.map('n', '<leader>d', ':bd<cr>', opt)
C.map('n', '<M-l>', ':bnext<cr>', opt)
C.map('n', '<M-h>', ':bprevious<cr>', opt)

-- File Explorer
C.map('n', '<leader>e', ':NvimTreeToggle<cr>', {silent = true})

-- Autocomplete
C.map("i", "<C-Space>", "compe#complete()", {expr = true})
C.map("i", "<CR>", "v:lua.completion_confirm()", {expr = true})
C.map("i", "<Tab>", "v:lua.tab_confirm()", {expr = true})

-- LSP
C.map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
C.map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
C.map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)

C.map("t", "<esc>", [[<C-\><C-n>]], {noremap = true})

C.map("n", "<leader>g", ":Neogit<CR>", opt)

C.map("v", "<Tab>",">gv", opt)
C.map("v", "<S-Tab>","<gv", opt)

--Format code
C.map("n", "<space>p", "<cmd>lua vim.lsp.buf.formatting()<CR>", opt)
C.map("v", "<space>p", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opt)

