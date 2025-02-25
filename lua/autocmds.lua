require "nvchad.autocmds"

-- add yours here!

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    require("conform").format { async = false, timeout_ms = 500 }
  end,
})
