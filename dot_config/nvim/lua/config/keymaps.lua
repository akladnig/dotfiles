-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  --@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Paste over currently selected text without yanking it
map("v", "p", '"_dP', { silent = true })
-- Better escape using jk in insert mode
map("i", "jk", "<ESC>")
-- Up/Down half a page and centre
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
-- Better viewing
map("n", "N", "Nzzzv")
map("n", "n", "nzzzv")
map("n", "g,", "g,zvzz")
map("n", "g;", "g;zvzz")

-- Move Lines ∆ is <A-j> and ˚ is <A-k>
-- TODO use clvnkhr/macaltkey.nvim?
map("n", "<∆-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<˚-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<∆-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<˚-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<∆-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<˚-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
-- buffers
if Util.has("bufferline.nvim") then
  map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
  map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
else
  map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
  map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
end
