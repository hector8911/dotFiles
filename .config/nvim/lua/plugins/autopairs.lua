
local npairs = require('nvim-autopairs')
npairs.setup()

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.completion_confirm = function()
  if vim.fn.pumvisible() == 1  then
    return vim.fn["compe#confirm"](npairs.esc("<cr>"))    
  else
    return npairs.autopairs_cr()
  end
end

_G.tab_confirm=function()
  if vim.fn.pumvisible() == 1  then
    return vim.fn["compe#confirm"](npairs.esc("<cr>"))
  else
    return t "<Tab>"
  end
end

