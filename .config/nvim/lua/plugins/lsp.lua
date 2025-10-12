return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      virtual_text = false, -- quita texto en línea
      update_in_insert = false,
    },
    servers = {
      tsserver = { enabled = false },
      ts_ls = { enabled = false },
      vtsls = {
        enabled = true,
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = "none" },
              parameterTypes = { enabled = false },
              variableTypes = { enabled = false },
              propertyDeclarationTypes = { enabled = false },
              functionLikeReturnTypes = { enabled = false },
              enumMemberValues = { enabled = false },
            },
          },
        },
      },
    },
  },
}
