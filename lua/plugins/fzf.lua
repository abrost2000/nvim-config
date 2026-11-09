local fzf = require("fzf-lua")

fzf.setup({})
-- Use fzf-lua for vim.ui.select (e.g. code actions from `gra`)
fzf.register_ui_select()

local map = function(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { desc = desc })
end

map("<leader>ff", fzf.files, "Find files")
map("<leader>fg", fzf.live_grep, "Live grep")
map("<leader>fw", fzf.grep_cword, "Grep word under cursor")
map("<leader>fb", fzf.buffers, "Buffers")
map("<leader>fh", fzf.helptags, "Help tags")
map("<leader>fr", fzf.resume, "Resume last picker")
map("<leader>fo", fzf.oldfiles, "Recent files")
map("<leader>fd", fzf.diagnostics_document, "Document diagnostics")
map("<leader>fs", fzf.lsp_document_symbols, "Document symbols")
