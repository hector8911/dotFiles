
local g = vim.g
g.nvim_tree_width = 35
g.nvim_tree_ignore = { 'node_modules', 'vendor', 'var' }
g.nvim_tree_gitignore = 1
g.nvim_tree_auto_close = 1
g.nvim_tree_quit_on_open = 1
g.nvim_tree_follow = 1
g.nvim_tree_indent_markers = 1
g.nvim_tree_hide_dotfiles = 1
g.nvim_tree_git_hl = 1
g.nvim_tree_root_folder_modifier = ':t'
g.nvim_tree_width_allow_resize  = 1
g.nvim_tree_add_trailing = 1
g.nvim_tree_group_empty = 1

g.nvim_tree_icons = {
  default = "",
  git = {
    unstaged = " ",
    staged = "",
    unmerged = "",
    renamed = "",
    untracked = "",
    deleted = ""
  }
}

require("nvim-tree").setup()

-- vim.g.nvim_tree_bindings = {
--     { key = ".", cb = tree_cb("toggle_dotfiles") },
--     { key = "l", cb = tree_cb("edit") },
--     { key = ",", cb = tree_cb("toggle_ignored") },
-- }

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '.', api.tree.toggle_dotfiles)
  vim.keymap.set('n', 'l',     api.tree.edit)
  vim.keymap.set('n', ',',     api.tree.toggle_ignored)
end

-- pass to setup along with your other options
require("nvim-tree").setup {
  ---
  on_attach = my_on_attach,
  ---
}
