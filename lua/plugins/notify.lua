return {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup {
      timeout = 3000,
      render = "minimal",
      stages = "slide",
    }
    vim.notify = require "notify"
  end,
  opts = {
    timeout = 3000,
    render = "compact",
  },
}
