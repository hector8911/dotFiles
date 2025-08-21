if vim.g.vscode then

-- set clipboard to global clipboard
vim.opt.clipboard:append("unnamedplus")
vim.g.mapleader = ' '


--Folding
vim.keymap.set(
    'n',
    '<leader>co',
    [[<Cmd>call VSCodeNotify('editor.toggleFold')<CR>]]
)

vim.keymap.set(
    'n',
    '<leader>ca',
    [[<Cmd>call VSCodeNotify('editor.foldLevel1')<CR>]]
)

vim.keymap.set(
    'n',
    '<leader>w',
    [[<Cmd>call VSCodeNotify('workbench.action.files.save')<CR>]]
)

vim.keymap.set(
    'n',
    '<leader>d',
    [[<Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>]]
)

vim.keymap.set(
    'n',
    '<leader>t',
    [[<Cmd>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>]]
)

vim.keymap.set(
    'n',
    'gn',
    [[<Cmd>call VSCodeNotify('workbench.action.nextEditorInGroup')<CR>]]
)

vim.keymap.set(
    'n',
    'ga',
    [[<Cmd>call VSCodeNotify('workbench.action.previousEditorInGroup')<CR>]]
)

vim.keymap.set(
    'n',
    'gcc',
    [[<Cmd>call VSCodeNotify('editor.action.commentLine')<CR>]]
)

vim.keymap.set(
    'v',
    'gcc',
    [[<Cmd>call VSCodeNotify('editor.action.commentLine')<CR>]]
)

-- packer.nvim config
-- ensure that packer is installed
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- configure plugins
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- comment/uncomment
    use {
        'numToStr/Comment.nvim',
        config = function()
            require'Comment'.setup()
        end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end
)

else
_G.P = {
  bg = "#181818",
  fg = "#626262",
  dark = '#272822',
  blue = '#1e8eff',
  orange = "#fd971f",
  yellow = "#fff800",
  green = "#8eff1e",
  red = "#ff1e8e",
  white = "#d8d8d8",
  grey = '#8F908A',
  light_grey = '#34352f',
  light_yellow = "#e2d873"
}

require('maps')
require('plugins')
require('settings')
require("plugins.statusline")
-- require("lazy")

    -- ordinary Neovim
end
