return {
  "stevearc/conform.nvim",
  opts = function()
    local opts = {
      formatters_by_ft = {
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        typescript = { "prettier" },
      },
      formatters = {
        prettier = {
          single_quote = true,
          jsx_single_quote = true,
        },
      },
    }
    return opts
  end,
}
