return {
  "folke/snacks.nvim",
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = false },
    picker = {
      sources = {
        files = {
          hidden = true,
          ignored = true,
        },
        explorer = {
          hidden = true,
            -- ignored = true,
          layout = { layout = {position = "right"} },
          follow_file = true,
          tree = true,
          focus = "list",
          jump = { close = false },
          auto_close = false,
          win = {
              list = {
                keys = {
                  ["."] = "explorer_focus",
                },
              },
            },
        },
      },
    },
    notifier = { enabled = false },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    -- { "<leader><space>", LazyVim.pick("files"), desc = "Smart Find Files" },
    -- { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
    -- { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    -- { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
{
        '<leader>e',
        function()
          local explorer_win = nil

          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            local ft = vim.bo[buf].filetype
            if ft == 'snacks_picker_list' then
              explorer_win = win
              break
            end
          end

          if vim.api.nvim_get_current_win() ~= explorer_win and explorer_win then
            vim.api.nvim_set_current_win(explorer_win)
          else
            Snacks.explorer()
          end
        end,
        desc = 'Snacks File Explorer',

      },
    --  --for git
    --{ "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    --{ "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    --{ "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    --{ "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
    --{ "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
    --{ "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
    --  --for LSPs
    --{ "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    --{ "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    --{ "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    --{ "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    --{ "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    },
}
