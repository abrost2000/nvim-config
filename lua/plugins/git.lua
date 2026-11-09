-- Tools for reviewing changes (yours or an agent's)

-- Gutter signs for changed lines, hunk actions, blame
require("gitsigns").setup({
  on_attach = function(bufnr)
    local gs = require("gitsigns")
    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
    end
    map("]h", function() gs.nav_hunk("next") end, "Next hunk")
    map("[h", function() gs.nav_hunk("prev") end, "Prev hunk")
    map("<leader>hs", gs.stage_hunk, "Stage hunk")
    map("<leader>hr", gs.reset_hunk, "Reset hunk")
    map("<leader>hp", gs.preview_hunk_inline, "Preview hunk")
    map("<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
  end,
})

-- Inline overlay of what changed, like `git diff` inside the buffer
require("mini.diff").setup({
  view = {
    style = "number", -- color line numbers; gitsigns owns the sign column
    overlay_style = "hunk",
  },
  mappings = {
    goto_next = "]c",
    goto_prev = "[c",
  },
})
vim.keymap.set("n", "<leader>go", function() require("mini.diff").toggle_overlay(0) end, { desc = "Toggle diff overlay" })

-- Side-by-side diff of all changes, with a file tree
require("codediff").setup({
  explorer = {
    width = 50,
    view_mode = "tree",
    line_stats = { enabled = true },
  },
})
vim.keymap.set("n", "<leader>dv", "<cmd>CodeDiff<cr>", { desc = "Review all changes" })
vim.keymap.set("n", "<leader>dh", "<cmd>CodeDiff history %<cr>", { desc = "File history (current file)" })
vim.keymap.set("n", "<leader>dH", "<cmd>CodeDiff history<cr>", { desc = "File history (repo)" })

-- Reload files changed on disk (e.g. by Claude Code in another pane).
-- Focus events don't reliably reach Neovim inside herdr/tmux, so also poll
-- every second. Only unmodified buffers are reloaded; ones with unsaved
-- edits get a warning instead.
vim.o.autoread = true

local function checktime()
  local mode = vim.api.nvim_get_mode().mode
  if mode:sub(1, 1) == "c" or vim.fn.getcmdwintype() ~= "" then return end
  vim.cmd("silent! checktime")
end

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "TermLeave" }, {
  group = vim.api.nvim_create_augroup("UserAutoReload", { clear = true }),
  callback = checktime,
})

local reload_timer = vim.uv.new_timer()
reload_timer:start(1000, 1000, vim.schedule_wrap(checktime))
