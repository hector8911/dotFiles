
--Location modules install
local PATH = vim.fn.stdpath('data').. "/lspinstall/"

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false
    }
)
-- Diagnostic error icons
vim.fn.sign_define("LspDiagnosticsSignError",{
  texthl = "StError", text = "", numhl = "StError"
})

vim.fn.sign_define("LspDiagnosticsSignWarning", {
  texthl = "StWarning", text = "",   numhl = "StWarning"
})
vim.fn.sign_define("LspDiagnosticsSignHint", {
  texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint"
})
vim.fn.sign_define("LspDiagnosticsSignInformation", {
  texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation"
})

vim.lsp.protocol.CompletionItemKind = {
  " Text ",
  " Method",
  " Function",
  " Constructor",
  "ﴲ Field",
  " Variable",
  " Class",
  "ﰮ Interface",
  " Module",
  "襁 Property",
  " Unit",
  " Value",
  "練 Enum",
  " Keyword",
  " Snippet",
  " Color",
  " File",
  " Reference",
  " Folder",
  " EnumMember",
  "ﲀ Constant",
  "ﳤ Struct",
  " Event",
  " TypeParameter"
}

--Languages server
require'lspconfig'.intelephense.setup {
  cmd = { PATH .. "php/node_modules/.bin/intelephense", "--stdio" }
  --on_attach = on_attach
}

require'lspconfig'.tsserver.setup {
  cmd = {PATH .. "typescript/node_modules/.bin/typescript-language-server", "--stdio"},

  --filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  --on_attach = require'lspconfig'.tsserver_on_attach,
  -- This makes sure tsserver is not used for formatting (I prefer prettier)
  --on_attach = on_attach,
  root_dir = require('lspconfig/util').root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git", "."),
}
