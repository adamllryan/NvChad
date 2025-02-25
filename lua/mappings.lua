require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<esc><cmd>w<cr>", { desc = "Save file" })

-- Lazy Keybind

map("n", "<leader>L", require("lazy").show, { desc = "Show Lazy" })

-- Indents

map("v", "<", "<gv")
map("v", ">", ">gv")

local copilot = pcall(require, "copilot")

if copilot then
  map("i", "<S-CR>", function()
    if require("copilot.suggestion").is_visible() then
      require("copilot.suggestion").accept_line()
      print "Accepted suggestion"
    end
  end, { desc = "Accept copilot suggestion" })
end

-- Harpoon

local harpoon = pcall(require, "harpoon")

if harpoon then
  -- finish later

  map("n", "<leader>a", function()
    harpoon:list():add()
  end, { desc = "Add current file to Harpoon" })
  map("n", "<leader>A", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end, { desc = "Toggle Harpoon menu" })

  map("n", "<leader>1", function()
    harpoon:list():select(1)
  end, { desc = "Select Harpoon list 1" })
  map("n", "<leader>2", function()
    harpoon:list():select(2)
  end, { desc = "Select Harpoon list 2" })
  map("n", "<leader>3", function()
    harpoon:list():select(3)
  end, { desc = "Select Harpoon list 3" })
  map("n", "<leader>4", function()
    harpoon:list():select(4)
  end, { desc = "Select Harpoon list 4" })
  map("n", "<leader>5", function()
    harpoon:list():select(5)
  end, { desc = "Select Harpoon list 5" })
end

-- Switch buffers

-- Clear Highlights after search

map("n", "<C-/>", "<cmd>nohlsearch<cr>", { desc = "Clear last search" })

-- Neovide keybinds

vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
map("n", "<C-=>", function()
  change_scale_factor(1.1)
end, { desc = "Increase scale factor" })
map("n", "<C-->", function()
  change_scale_factor(0.9)
end, { desc = "Decrease scale factor" })

-- File Explorer keybinds

-- map({ "n", "v" }, "<tab>", "<cmd>Neotree toggle left last<cr>", {desc = "Toggle file explorer"})
map({ "n", "v" }, "<tab>", "<cmd>lua Snacks.explorer()<cr>", { desc = "Toggle file explorer" })

-- Terminal keybinds

map("n", "t", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Toggle terminal" })
map("t", "<esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map({ "t", "n" }, "<C-\\>", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle terminal" })

local window_keys = {
  ["<C-h>"] = "Navigate windows to the left",
  ["<C-j>"] = "Navigate windows down",
  ["<C-k>"] = "Navigate windows up",
  ["<C-l>"] = "Navigate windows to the right",
}

for key, desc in pairs(window_keys) do
  map("n", key, "<C-w><C-" .. key .. ">", { desc = desc })
  map("t", key, "<C-\\><C-n><C-w><C-" .. key .. ">", { desc = desc })
end

-- Change buffer like tabs

local buffer_keys = {
  l = { cmd = "<cmd>bnext<CR>", desc = "Next buffer" },
  h = { cmd = "<cmd>bprevious<CR>", desc = "Previous buffer" },
}

for key, mapping in pairs(buffer_keys) do
  map("n", "<S-" .. key .. ">", mapping.cmd, { desc = mapping.desc })
end

-- Comment lines

map("n", "<C-/>", "<S-V>gcc", { desc = "Comment line" })
map("v", "<C-/>", "gcc", { desc = "Comment line" })
