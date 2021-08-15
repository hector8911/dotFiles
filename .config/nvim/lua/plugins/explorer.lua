
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

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
  vim.g.nvim_tree_bindings = {
    { key = ".", cb = tree_cb("toggle_dotfiles") },
    { key = "l", cb = tree_cb("edit") },
    { key = ",", cb = tree_cb("toggle_ignored") },
}

