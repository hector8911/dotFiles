if vim.g.vscode then
  -- VSCode extension
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
      'tn',
      [[<Cmd>call VSCodeNotify('workbench.action.nextEditorInGroup')<CR>]]
  )
  vim.keymap.set(
      'n',
      'ta',
      [[<Cmd>call VSCodeNotify('workbench.action.previousEditorInGroup')<CR>]]
  )
else
  -- ordinary Neovim
  -- bootstrap lazy.nvim, LazyVim and your plugins
  require("config.lazy")
end
