return {
  "catppuccin/nvim",
  lazy = true,
  name = "catppuccin",
  priority = 1000,
  build = ":CatppuccinCompile",
  opts = {
    flavour = "mocha", -- Can be one of: latte, frappe, macchiato, mocha
    background = { light = "latte", dark = "mocha" },
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
    },
    transparent_background = false,
    show_end_of_buffer = false,
    term_colors = false,
    compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    styles = {
      comments = { "italic" },
      functions = {},
      keywords = { "italic" },
      operators = {},
      conditionals = {},
      loops = {},
      booleans = { "italic" },
      numbers = {},
      types = {},
      strings = {},
      variables = {},
      properties = {},
    },
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
      },
      alpha = true,
      barbar = true,
      beacon = false,
      cmp = true,
      dap = { enabled = true, enable_ui = true },
      gitsigns = true,
      hop = true,
      indent_blankline = { enabled = false, colored_indent_levels = true },
      lsp_saga = true,
      lsp_trouble = true,
      markdown = true,
      mason = true,
      mini = true,
      neogit = false,
      neotree = { enabled = true, show_root = true, transparent_panel = true },
      noice = true,
      notify = true,
      telescope = true,
      treesitter_context = false,
      ts_rainbow2 = true,
      which_key = true,
    },
    color_overrides = {
      mocha = {
        rosewater = "#F5E0DC",
        flamingo = "#F2CDCD",
        mauve = "#8980FE", -- functions and return
        -- mauve = "#DDB6F2",
        pink = "#F5C2E7",
        red = "#F28FAD",
        maroon = "#E8A2AF",
        peach = "#FEC880", -- true, false
        yellow = "#FAE3B0",
        green = "#9AFEA0", -- Strings
        blue = "#96CDFB",
        sky = "#FE98FA", -- operators
        teal = "#B5E8E0",
        lavender = "#F1E6FF", -- Text
        text = "#D9E0EE",
        subtext1 = "#BAC2DE",
        subtext0 = "#A6ADC8",
        overlay2 = "#C3BAC6",
        overlay1 = "#988BA2",
        overlay0 = "#9666CC", -- comments
        surface2 = "#6E6C7E",
        surface1 = "#9666CC", -- Line numbers
        surface0 = "#343074",
        base = "#211B41",
        mantle = "#1C1830",
        crust = "#169320",
      },
    },
    custom_highlights = function(C)
      return {
        TreesitterContext = { bg = C.mantle, fg = C.text },
      }
    end,
  },
}
