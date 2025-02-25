-- Load default NvChad LSP settings
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- List of LSP servers to configure
local servers = {
  "clangd", -- C/C++
  "pyright", -- Python
  "ts_ls",
  "html",
  "cssls",
  "lua_ls",
}

-- Configure each LSP with NvChad's defaults
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Recognize "vim" as a global variable in Lua

lspconfig.lua_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }, -- Recognize 'vim' as a global to fix warnings
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME, -- Make LSP aware of Neovim runtime files
          "${3rd}/luv/library",
          "${3rd}/busted/library",
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
      telemetry = {
        enable = false, -- Disable telemetry for privacy
      },
    },
  },
}
