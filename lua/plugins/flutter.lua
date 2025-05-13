-- Don't try to load this plugin if the flutter command is not available

local path = os.getenv "PATH" or ""

if not path:find "flutter" then
  print "FLUTTER_HOME environment variable is not set."
  return {}
end

-- For use in making flutter workspace

return {
  "akinsho/flutter-tools.nvim",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- optional for vim.ui.select
  },
}
