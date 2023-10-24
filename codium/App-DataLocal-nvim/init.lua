-- set clipboard to global clipboard
vim.opt.clipboard:append("unnamedplus")
vim.g.mapleader = ' '

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