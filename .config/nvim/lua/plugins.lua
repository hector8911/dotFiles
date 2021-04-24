
--get config M(namePlugin, filename)
local M = require("utils").load_plugin

-- Install packer.nvim if not exists
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim ' ..install_path)
end
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    -- Color scheme
    use 'tanvirtin/monokai.nvim'
    use 'sheerun/vim-polyglot'

    -- LSP - Autocomplete
    use {'neovim/nvim-lspconfig' , config = M("nvim-lspconfig", "lsp")}
    use {'hrsh7th/nvim-compe', config = M("nvim-compe", "completion")}
    use 'kabouzeid/nvim-lspinstall'
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = M("nvim-treesitter", "treesitter")}

    use {'windwp/nvim-autopairs', config = M("nvim-autopairs", "autopairs")}
    use 'alvan/vim-closetag'
    use 'hrsh7th/vim-vsnip'
    use "rafamadriz/friendly-snippets"

    -- Git
    use {'tpope/vim-fugitive'}
    use {"TimUntersberger/neogit", config = M("neogit", "neogit")}
    use 
    {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = M("gitsigns.nvim", "gitsigns")
    }

    -- Explorer
    use 'kyazdani42/nvim-web-devicons'
    use {'kyazdani42/nvim-tree.lua', config = M("nvim-tree.lua", "explorer")}

    -- Terminal
    use {"akinsho/nvim-toggleterm.lua", config = M("nvim-toggleterm.lua", "terminal")}

    -- Tabs buffers
    use {'akinsho/nvim-bufferline.lua', config = M("nvim-bufferline.lua", "bufferline")}

end)
