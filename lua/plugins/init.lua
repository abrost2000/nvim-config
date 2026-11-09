vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" and ev.data.kind ~= "delete" then
      if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
      vim.cmd("TSUpdate")
    end
  end,
})

vim.pack.add({
  "https://github.com/mason-org/mason.nvim",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/craftzdog/solarized-osaka.nvim",
  "https://github.com/nvim-mini/mini.icons",
  -- LSP / tooling
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  "https://github.com/stevearc/conform.nvim",
  -- Git / reviewing changes
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/nvim-mini/mini.diff",
  "https://github.com/esmuellert/codediff.nvim",
})
