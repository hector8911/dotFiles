
local M = {}
local fn = vim.fn

function M.create(definitions)
  for group_name, definition in pairs(definitions) do
    vim.cmd("augroup " .. group_name)
    vim.cmd("autocmd!")
    for _, def in pairs(definition) do
      local command = table.concat(vim.tbl_flatten {"autocmd", def}, " ")
      vim.cmd(command)
    end
    vim.cmd("augroup END")
  end
end

function M.augroup(name, commands)
  vim.cmd("augroup " .. name)
  vim.cmd("autocmd!")
  for _, c in ipairs(commands) do
    vim.cmd(string.format("autocmd %s %s %s %s",
      table.concat(c.events, ","),
      table.concat(c.targets or {}, ","),
      table.concat(c.modifiers or {}, " "),
      c.command
    ))
  end
  vim.cmd("augroup END")
end

--- automatically clear commandline messages
local function clear_messages()
  local id
  return function()
    if id then fn.timer_stop(id) end
    id = fn.timer_start(1500, function()
      if fn.mode() == "n" then vim.cmd [[echon '']] end
    end)
  end
end

M.clear_messages = clear_messages()

M.augroup("ClearCommandMessages", {
  {
    events = { "CmdlineLeave", "CmdlineChanged" },
    targets = { ":" },
    command = "lua require('utils.autocommands').clear_messages()"
  }
})

vim.cmd "au BufNewFile,BufRead,BufReadPost *.pug set filetype=pug"

return M

