-- oxfmt only runs in projects with an .oxfmtrc.json(c); otherwise prettierd, then prettier
local web = { "oxfmt", "prettierd", "prettier", stop_after_first = true }

require("conform").setup({
  formatters_by_ft = {
    javascript = web,
    typescript = web,
    javascriptreact = web,
    typescriptreact = web,
    json = web,
    jsonc = web,
    css = web,
    scss = web,
    html = web,
    markdown = web,
    yaml = web,
    lua = { "stylua" },
  },
  formatters = {
    oxfmt = { require_cwd = true },
  },
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
})

vim.keymap.set({ "n", "x" }, "<leader>cf", function()
  require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format" })

vim.keymap.set("n", "<leader>uf", function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat
  vim.notify("Format on save " .. (vim.g.disable_autoformat and "off" or "on"))
end, { desc = "Toggle format on save" })
