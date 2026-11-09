-- Overrides on top of nvim-lspconfig's lua_ls defaults (cmd, filetypes come from there)
---@type vim.lsp.Config
return {
  root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        library = { vim.env.VIMRUNTIME },
        checkThirdParty = false,
      },
    },
  },
}
