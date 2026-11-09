local parsers = {
  "lua", "luadoc", "vim", "vimdoc", "query",
  "javascript", "typescript", "tsx", "jsdoc",
  "json", "yaml", "html", "css", "scss", "markdown", "markdown_inline", "bash",
}

-- Installs any missing parsers (no-op if already installed)
require("nvim-treesitter").install(parsers)

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
  callback = function(ev)
    -- Only start if a parser exists for this filetype
    if not pcall(vim.treesitter.start, ev.buf) then return end

    -- Treesitter-based folding (start with everything unfolded)
    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldlevel = 99

    -- Treesitter-based indentation
    vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
