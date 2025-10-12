local map = LazyVim.safe_keymap_set

map("n", "ta", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })

map("n", "tn", "<cmd>bprevious<cr>", { desc = "Next Buffer" })

map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Exit" })

map("n", "<leader>d", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })

map("n", "<leader>do", function()
  Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })

-- terminal
map("n", "<leader>t", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
