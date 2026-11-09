-- Base configs come from nvim-lspconfig; overrides live in after/lsp/<name>.lua
vim.lsp.enable({
  "vtsls",       -- TypeScript / JavaScript
  "eslint",      -- only attaches in projects with an ESLint config
  "oxlint",      -- only attaches in projects with an .oxlintrc.json
  "tailwindcss", -- only attaches in projects using Tailwind
  "lua_ls",
})

-- Show diagnostic messages inline at the end of the line
vim.diagnostic.config({ virtual_text = true })

-- Characters that should pop the completion menu (in addition to the
-- server's own triggerCharacters like "." or ":").
local trigger_chars = vim.split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_", "")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then return end

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })

    -- Inlay hints (parameter names, return types...); <leader>uh toggles
    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
      vim.keymap.set("n", "<leader>uh", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
      end, { buffer = ev.buf, desc = "Toggle inlay hints" })
    end

    if client:supports_method("textDocument/completion") then
      -- Trigger on every identifier keypress, not just "." etc.
      -- LspAttach fires once per buffer, so only extend the list once per client.
      local provider = client.server_capabilities.completionProvider
      if not client._user_trigger_chars then
        provider.triggerCharacters = vim.list_extend(provider.triggerCharacters or {}, trigger_chars)
        client._user_trigger_chars = true
      end

      vim.lsp.completion.enable(true, client.id, ev.buf, {
        autotrigger = true,
        -- Strip "(...)" from labels so the menu stays clean
        convert = function(item)
          return { abbr = item.label:gsub("%b()", "") }
        end,
      })

      -- Manually open the menu
      vim.keymap.set("i", "<C-Space>", vim.lsp.completion.get, { buffer = ev.buf, desc = "LSP completion" })
    end
  end,
})

-- <Tab>/<S-Tab> cycle the menu, <CR> accepts the selected item
local function pum(key, fallback)
  return function()
    return vim.fn.pumvisible() == 1 and key or fallback
  end
end
vim.keymap.set("i", "<Tab>", pum("<C-n>", "<Tab>"), { expr = true })
vim.keymap.set("i", "<S-Tab>", pum("<C-p>", "<S-Tab>"), { expr = true })
vim.keymap.set("i", "<CR>", function()
  if vim.fn.pumvisible() == 1 and vim.fn.complete_info({ "selected" }).selected ~= -1 then
    return "<C-y>"
  end
  return "<CR>"
end, { expr = true })
