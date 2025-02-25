return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "InsertEnter",
  opts = {
    panel = {
      enabled = true,
      auto_refresh = true,
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      accept = false,
      debounce = 75,
    },
    filetypes = {
      ["."] = true,
    },
    copilot_node_command = vim.fn.exepath "node",
    root_dir = vim.fn.getcwd(),
  },
}
