-- Glassy look: the theme draws no background, so Ghostty's
-- background-opacity + background-blur-radius show through.
require("solarized-osaka").setup({
  transparent = true,
  styles = {
    sidebars = "transparent", -- help, quickfix
    floats = "transparent",   -- hover docs, completion menu, fzf-lua
  },
})

vim.cmd.colorscheme("solarized-osaka")

-- Transparent floats need a border so you can see their edges
vim.o.winborder = "rounded"
