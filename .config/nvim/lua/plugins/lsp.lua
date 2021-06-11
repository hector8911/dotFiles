
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false
  }
)

vim.cmd 'autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()'
vim.cmd 'autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()'

-- Diagnostic icons
vim.fn.sign_define("LspDiagnosticsSignError", {
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

-- Languages server
local nvim_lsp = require('lspconfig')
local servers = { "intelephense", "tsserver" }

for _, lsp in ipairs(servers) do 
  nvim_lsp[lsp].setup {
    on_attach = function(client, bufnr)
      -- to format with prettier
      if lsp == "tsserver" then
        client.resolved_capabilities.document_formatting = false
      end
    end
  } 
end

local prettier = {
  formatCommand = 'prettier --find-config-path --stdin-filepath ${INPUT}',
  formatStdin = true
}

require'lspconfig'.efm.setup{
  cmd = { os.getenv('HOME').."/go/bin/efm-langserver" },
  init_options = { documentFormatting = true },
  filetypes = { 
    "javascriptreact", 
    "javascript", 
    "typescript",
    "html", 
    "css", 
    "json"
  },
  settings = {
    languages = {
      json = { prettier },
      javascript = { prettier },
      javascriptreact = { prettier },
      typescript = { prettier },
      typescriptreact = { prettier },
      css = { prettier },
      html = { prettier }
    }
  }
}

