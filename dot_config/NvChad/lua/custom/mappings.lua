---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "Enter command mode", opts = { nowait = true } },
    ["<leader>qq"] = { "<cmd>qa<CR>", "Quit All" },
    ["<C-d>"] = { "<C-d>zz", "Half page down and re-centre" },
    ["<C-u>"] = { "<C-u>zz", "Half page up and re-centre" },
    -- Move Lines ∆ is <A-j> and ˚ is <A-k>
    ["<A-j>"] = { "<cmd>m .+1<cr>==", "Move line down" },
    ["<A-k>"] = { "<cmd>m .-2<cr>==", "Move line up" },
  },
  i = {
    ["<A-j>"] = { "<esc><cmd>m .+1<cr>==gi", "Move line down" },
    ["<A-k>"] = { "<esc><cmd>m .-2<cr>==gi", "Move line up" },
  },
  v = {
    ["<A-j>"] = { ":m '>+1<cr>gv=gv", "Move line down" },
    ["<A-k>"] = { ":m '<-2<cr>gv=gv", "Move line up" },
  },
}

-- more keybinds!

return M
