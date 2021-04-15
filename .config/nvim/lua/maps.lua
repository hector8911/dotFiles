local C = require('utils')
vim.g.mapleader = ' '

-- Clear highlights
C.map('n', '<Esc>', '<cmd>noh<CR>')
--Save and exit
C.map('n', '<leader>w', ':w<cr>', { noremap=true, silent = true })
C.map('n', '<leader>q', ':q<cr>', { noremap=true, silent = true })
--Buffers
C.map('n', '<leader>d', ':bd<cr>', { noremap=true, silent = true })
C.map('n', '<M-l>', ':bnext<cr>', { noremap=true, silent = true })
C.map('n', '<M-h>', ':bprevious<cr>', { noremap=true, silent = true })

--File Explorer
C.map('n', '<leader>e', ':NvimTreeToggle<cr>', { silent = true })

--Autocomplete
C.map("i", "<C-Space>", "compe#complete()", {expr = true})
C.map("i", "<CR>", "compe#confirm('<CR>')",{expr = true, noremap = true, silent = true})
C.map("i", "<Tab>", "compe#confirm('<CR>')",{expr = true, noremap = true, silent = true})
--

--Indent
C.map("n", "<leader>f", ":bufdo normal gg=G<CR>", {noremap = true})

--LSP
C.map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>",{noremap = true, silent = true})
--C.map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>",{noremap = true, silent = true})
C.map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>",{noremap = true, silent = true})
C.map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>",{noremap = true, silent = true})

local autocommands = require("utils.autocommands")
_G.maps = {}
function _G.maps.add_terminal_mappings()
    if vim.bo.filetype == "" or vim.bo.filetype == "toggleterm" then
      local opts = {silent = false}

      --C.map("t", "<esc>", "<cmd>lua <C-t><CR>", opts)
      --tnoremap("<esc>", [[<C-\><C-n>]], opts)

    end
  end

  autocommands.create(
    {
      AddTerminalMappings = {
        {"TermEnter,BufEnter", "term://*", "lua maps.add_terminal_mappings()"}
      }
    }
  )

