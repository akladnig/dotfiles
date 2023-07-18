---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "chadracula",
  theme_toggle = { "chadracula", "catppuccin" },
  changed_themes = {
    chadracula = {
      -- black = usually your theme bg
      -- darker_black = 6% darker than black
      -- black2 = 6% lighter than black
      --
      -- onebg = 10% lighter than black
      -- oneb2 = 19% lighter than black
      -- oneb3 = 27% lighter than black
      --
      -- grey = 40% lighter than black (the % here depends so choose the perfect grey!)
      -- grey_fg = 10% lighter than grey
      -- grey_fg2 = 20% lighter than grey
      -- light_grey = 28% lighter than grey
      --
      -- baby_pink = 15% lighter than red or any babypink color you like!
      -- line = 15% lighter than black
      --
      -- nord_blue = 13% darker than blue
      -- sun = 8% lighter than yellow
      --
      -- statusline_bg = 4% lighter than black
      -- lightbg = 13% lighter than statusline_bg
      -- lightbg2 = 7% lighter than statusline_bg
      --
      -- folder_bg = blue color

      base_30 = {
        white = "#F8F8F2",
        darker_black = "#1C1830",
        black = "#211B41", --  nvim bg
        black2 = "#2C2357",
        one_bg = "#332965", -- real bg of onedark
        one_bg2 = "#443786",
        one_bg3 = "#5343A3",
        grey = "#9666CC", -- Line Numbers
        grey_fg = "#7B40BF", -- Comments
        grey_fg2 = "#CAB3E6",
        light_grey = "#DFD1F0",
        red = "#ff7070",
        baby_pink = "#ff86d3",
        pink = "#FF79C6",
        line = "#3c3d49", -- for lines like vertsplit
        green = "#50fa7b",
        vibrant_green = "#5dff88",
        nord_blue = "#8b9bcd",
        blue = "#a1b1e3",
        yellow = "#F1FA8C",
        sun = "#FFFFA5",
        purple = "#BD93F9",
        dark_purple = "#BD93F9",
        teal = "#92a2d4",
        orange = "#FFB86C",
        cyan = "#8BE9FD",
        statusline_bg = "#282150",
        lightbg = "#40347F",
        lightbg2 = "#4D3E98",
        pmenu_bg = "#ABE9B3",
        folder_bg = "#9666CC",
      },

      -- base00 - Default Background
      -- base01 - Lighter Background (Used for status bars, line number and folding marks)
      -- base02 - Selection Background
      -- base03 - Comments, Invisibles, Line Highlighting
      -- base04 - Dark Foreground (Used for status bars)
      -- base05 - Default Foreground, Caret, Delimiters, Operators
      -- base06 - Light Foreground (Not often used)
      -- base07 - Light Background (Not often used)
      -- base08 - Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
      -- base09 - Integers, Boolean, Constants, XML Attributes, Markup Link Url
      -- base0A - Classes, Markup Bold, Search Text Background
      -- base0B - Strings, Inherited Class, Markup Code, Diff Inserted
      -- base0C - Support, Regular Expressions, Escape Characters, Markup Quotes
      -- base0D - Functions, Methods, Attribute IDs, Headings
      -- base0E - Keywords, Storage, Selector, Markup Italic, Diff Changed
      -- base0F - Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>

      base_16 = {
        base00 = "#211B41",
        base01 = "#1C1830",
        base02 = "#9d4f68",
        base03 = "#9666CC",
        base04 = "#62d6e8",
        base05 = "#e9e9f4",
        base06 = "#f1f2f8",
        base07 = "#f7f7fb",
        base08 = "#c197fd",
        base09 = "#FFB86C",
        base0A = "#62d6e8",
        base0B = "#F1FA8C",
        base0C = "#8BE9FD",
        base0D = "#50fa7b",
        base0E = "#ff86d3",
        base0F = "#F8F8F2",
      },
    },

    catppuccin = {
      base_30 = {
        white = "#D9E0EE",
        darker_black = "#1C1830",
        black = "#211B41", --  nvim bg
        black2 = "#2C2357",
        one_bg = "#332965", -- real bg of onedark
        one_bg2 = "#443786",
        one_bg3 = "#5343A3",
        grey = "#474656",
        grey_fg = "#4e4d5d",
        grey_fg2 = "#555464",
        light_grey = "#605f6f",
        red = "#F38BA8",
        baby_pink = "#ffa5c3",
        pink = "#F5C2E7",
        line = "#383747", -- for lines like vertsplit
        green = "#ABE9B3",
        vibrant_green = "#b6f4be",
        nord_blue = "#8bc2f0",
        blue = "#89B4FA",
        yellow = "#FAE3B0",
        sun = "#ffe9b6",
        purple = "#d0a9e5",
        dark_purple = "#c7a0dc",
        teal = "#B5E8E0",
        orange = "#F8BD96",
        cyan = "#89DCEB",
        statusline_bg = "#282150",
        lightbg = "#40347F",
        lightbg2 = "#4D3E98",
        pmenu_bg = "#ABE9B3",
        folder_bg = "#9666CC",
        lavender = "#c7d1ff",
      },
      base_16 = {
        base00 = "#211B41",
        base01 = "#1C1830",
        base02 = "#2f2e3e",
        base03 = "#383747",
        base04 = "#414050",
        base05 = "#bfc6d4",
        base06 = "#ccd3e1",
        base07 = "#D9E0EE",
        base08 = "#F38BA8",
        base09 = "#F8BD96",
        base0A = "#FAE3B0",
        base0B = "#ABE9B3",
        base0C = "#89DCEB",
        base0D = "#89B4FA",
        base0E = "#CBA6F7",
        base0F = "#F38BA8",
      },
      -- and so on!
    },
  },
  hl_override = highlights.override,
  hl_add = highlights.add,
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
