require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- Installs these automatically on startup (only if missing)
require("mason-tool-installer").setup({
  ensure_installed = {
    -- Language servers
    "lua-language-server",
    "vtsls",
    "eslint-lsp",
    "oxlint",
    "tailwindcss-language-server",
    -- Formatters
    "oxfmt",
    "prettierd",
    "prettier",
    "stylua",
  },
  auto_update = false,
  run_on_start = true,
})
