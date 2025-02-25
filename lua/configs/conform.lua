local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    c = { "clang-format" }, -- Format C code
    cpp = { "clang-format" }, -- Format C++ code
    python = { "black" }, -- Format Python
    javascript = { "prettier" }, -- Uncomment if you want Prettier for JS
    typescript = { "prettier" },
    json = { "jq" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    sh = { "shfmt" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
