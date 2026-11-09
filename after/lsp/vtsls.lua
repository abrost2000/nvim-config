-- Overrides on top of nvim-lspconfig's vtsls defaults (from craftzdog's setup)

-- Same language settings for TS and JS files
local lang = {
  updateImportsOnFileMove = { enabled = "always" },
  suggest = { completeFunctionCalls = true },
  preferences = { useAliasesForRenames = false },
  inlayHints = {
    enumMemberValues = { enabled = true },
    functionLikeReturnTypes = { enabled = true },
    parameterNames = { enabled = "literals" },
    parameterTypes = { enabled = true },
    propertyDeclarationTypes = { enabled = true },
    variableTypes = { enabled = false },
  },
}

---@type vim.lsp.Config
return {
  settings = {
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true, -- use the project's own TypeScript version
      experimental = {
        maxInlayHintLength = 30,
        completion = { enableServerSideFuzzyMatch = true },
      },
    },
    typescript = lang,
    javascript = lang,
  },
}
