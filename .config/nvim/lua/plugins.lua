
-- get config M(namePlugin, filename)
local M = require("utils").load_plugin

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
  -- LSP - Autocomplete
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/nvim-compe' },
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },

  { 'windwp/nvim-autopairs' },
  { 'windwp/nvim-ts-autotag'},
  {'hrsh7th/vim-vsnip'},
  {"rafamadriz/friendly-snippets"},


  -- Git
  { 'tpope/vim-fugitive' },
  { 'nvim-lua/plenary.nvim' },
  { 'TimUntersberger/neogit', config = M('neogit', 'neogit') },
  { 'lewis6991/gitsigns.nvim', config = M('gitsigns.nvim', 'gitsigns') },

  -- Explorer
  { 'kyazdani42/nvim-web-devicons', config = M('nvim-web-devicons', 'devicons') },
  { 'kyazdani42/nvim-tree.lua', config = M('nvim-tree.lua', 'explorer') },

  -- Terminal
  { 'akinsho/nvim-toggleterm.lua', config = M('nvim-toggleterm.lua', 'terminal') },

  -- Tabs buffers
  { 'akinsho/nvim-bufferline.lua', config = M('nvim-bufferline.lua', 'bufferline') },

  -- Comment
  {'JoosepAlviste/nvim-ts-context-commentstring'},
  {'tpope/vim-commentary'},

  -- hi pug
  {'digitaltoad/vim-jade'},

  },

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  --install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

