vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.undofile = true

vim.o.termguicolors = true

-- netrw: hide the banner, show only the file tree
vim.g.netrw_banner = 0

-- LSP autotrigger handles this (see plugins/lsp.lua); native autocomplete would fight it
vim.o.autocomplete = false
vim.o.completeopt = "menuone,noselect,popup,fuzzy"
