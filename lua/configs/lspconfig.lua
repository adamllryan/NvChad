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
  "kotlin_language_server",
}

-- Configure each LSP with NvChad's defaults
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Custom configuration for clangd (C/C++ LSP)

local function get_platform_defines()
  local uname = vim.loop.os_uname().sysname
  if uname == "Darwin" then
    return { "-D__APPLE__", "-I/usr/local/include", "-I./include" }
  elseif uname == "Linux" then
    return { "-D__linux__", "-I/usr/include", "-I./include" }
  else
    return { "-DUNKNOWN_PLATFORM" } -- Fallback if unknown OS
  end
end

lspconfig.clangd.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=never" },
  init_options = {
    clangdFileStatus = true,
    fallbackFlags = get_platform_defines(),
  },
}

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
