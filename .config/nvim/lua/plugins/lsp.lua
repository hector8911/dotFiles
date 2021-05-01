
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
local nvim_lsp = require('lspconfig')
local servers = {"intelephense", "tsserver"}
for _, lsp in ipairs(servers) do 
	nvim_lsp[lsp].setup {} 
end

