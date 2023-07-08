--[[ lvim is the global options object Linters should be filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- require("adrian.plugins")
require("adrian.keymaps")
require("adrian.options")

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
vim.opt.spell = false
vim.opt.spelllang = { "en" }
vim.opt.termguicolors = true
lvim.builtin.treesitter.rainbow.enable = true
lvim.colorscheme = "dracula"
vim.wo.relativenumber = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

lvim.builtin.dap.active = true

local dracula = require("dracula")
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "flutter")
end

local rainbow = require 'ts-rainbow'
lvim.builtin.terminal.direction = "vertical"
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "go",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "dart",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- Additional Plugins
lvim.plugins = {

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "*" },
        {
          RGB = true,      -- #RGB hex codes
          RRGGBB = true,   -- #RRGGBB hex codes
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          rgb_fn = true,   -- CSS rgb() and rgba() functions
          hsl_fn = true,   -- CSS hsl() and hsla() functions
          css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
        })
    end,
  },
  {
    "ggandor/leap.nvim",
    lazy = false,
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  "HiPhish/nvim-ts-rainbow2",

  require("nvim-treesitter.configs").setup {
    rainbow = {
      query = {
        'rainbow-parens'
      },
      strategy = rainbow.strategy.global,
      hlgroups = {
        'TSRainbowRed',
        'TSRainbowYellow',
        'TSRainbowBlue',
        'TSRainbowOrange',
        'TSRainbowGreen',
        'TSRainbowViolet',
        'TSRainbowCyan'
      },
    }
  },
  'ThePrimeagen/vim-be-good',
  -- { "rcarriga/nvim-dap-ui" },
  { 'akinsho/flutter-tools.nvim',              require = 'nvim-lua/plenary.nvim', },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },

  -- Snippets
  { "RobertBrunhage/flutter-riverpod-snippets" },
  { "Neevash/awesome-flutter-snippets" },
  -- { 'Rigellute/shades-of-purple.vim' },
  { 'Mofiqul/dracula.nvim' },
  dracula.setup({
    -- customize dracula color palette
    colors = {
      -- bg = "#383a59",
      bg = "#272457",
      fg = "#F1E6FF", --done
      selection = "#44475A",
      comment = "#9666CC",
      red = "#FE6167",    -- done
      orange = "#FEC880", -- done
      yellow = "#F7FF80", -- done
      green = "#80FE89",  -- done
      purple = "#8980FE", -- done
      cyan = "#80F6FE",   -- done
      pink = "#FE80F6",   -- done
      bright_red = "#FE7167",
      bright_green = "#1CFE67",
      bright_yellow = "#FFFFA5",
      bright_blue = "#D6ACFF",
      bright_magenta = "#FF92DF",
      bright_cyan = "#A4FFFF",
      bright_white = "#FFFFFF",
      menu = "#1D1B41",
      visual = "#3E4452",
      gutter_fg = "#4B5263",
      nontext = "#3B4048",
      white = "#F1E6FF",
      black = "#1D1B41",
    },
    -- show the '~' characters after the end of buffers
    show_end_of_buffer = true,    -- default false
    -- use transparent background
    transparent_bg = false,       -- default false
    -- set custom lualine background color
    lualine_bg_color = "#44475a", -- default nil
    -- set italic comment
    italic_comment = true,        -- default false
    -- overrides the default highlights with table see `:h synIDattr`
    overrides = {},
    -- You can use overrides as table like this
    -- overrides = {
    --   NonText = { fg = "white" }, -- set NonText fg to white
    --   NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
    --   Nothing = {} -- clear highlight of Nothing
    -- },
    -- Or you can also use it like a function to get color from theme
    -- overrides = function (colors)
    --   return {
    --     NonText = { fg = colors.white }, -- set NonText fg to white of theme
    --   }
    -- end,
  }),
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
      })
    end
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    lazy = true,
    config = function()
      require("persistence").setup()
    end,
  },
}
lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics",
  t = { "<cmd>TroubleToggle<cr>", "trouble" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}

lvim.builtin.which_key.mappings["S"] = {
  name = "Session",
  c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
  l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
  Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}
lvim.builtin.dap.on_config_done = function(dap)
  dap.defaults.dart.exception_breakpoints = { 'raised' }
  dap.adapters.dart = {
    type = "executable",
    command = "node",
    args = { os.getenv("HOME") .. "/.local/share/nvim/dapinstall/dart-code/out/dist/debug.js", "flutter" },
  }

  dap.configurations.dart = {
    {
      type = "dart",
      request = "launch",
      name = "Launch Flutter",
      dartSdkPath = os.getenv("HOME") .. "/Development/flutter/bin/cache/dart-sdk/",
      flutterSdkPath = os.getenv("HOME") .. "/Development/flutter",
      program = "${workspaceFolder}/lib/main.dart",
      cwd = "${workspaceFolder}",
    },
    {
      type = "dart",
      dartSdkPath = os.getenv("HOME") .. "/Development/flutter/bin/cache/dart-sdk/",
      name = "Flutter Dev",
      request = "launch",
      flutterSdkPath = os.getenv("HOME") .. "/Development/flutter",
      program = "lib/main_dev.dart",
      args = { "--flavor", "dev" },
    },
  }
end

require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  expand_lines = vim.fn.has("nvim-0.7"),
  layouts = {
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "↻",
      terminate = "□",
    },
  },
  floating = {
    max_height = nil,  -- These can be integers or a float between 0 and 1.
    max_width = nil,   -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  }
})

local on_attach = function(_, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  -- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
end
require("flutter-tools").setup {
  decorations = {
    statusline = {
      -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
      -- this will show the current version of the flutter app from the pubspec.yaml file
      app_version = true,
      -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
      -- this will show the currently running device if an application was started with a specific
      -- device
      device = true,
    }
  },
  debugger = {
    -- integrate with nvim dap + install dart code debugger
    enabled = true,
    run_via_dap = true, -- use dap instead of a plenary job to run flutter apps
    register_configurations = function()
      require("dap").configurations.dart = {
        {
          dartSdkPath = "/Applications/flutter/bin/cache/dart-sdk/",
          name = "Flutter Dev",
          request = "launch",
          flutterSdkPath = "/Development/flutter",
          type = "dart",
          program = "lib/main_dev.dart",
          args = { "--flavor", "dev" },
        }
      }
    end
  },
  --flutter_path = "<full/path/if/needed>", -- <-- this takes priority over the lookup
  --flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
  fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
  widget_guides = {
    enabled = true,
  },
  closing_tags = {
    highlight = "Comment", -- highlight for the closing tag
    prefix = "^",          -- character to use for close tag e.g. > Widget
    enabled = true         -- set to false to disable
  },
  dev_log = {
    enabled = true,
    open_cmd = "tabedit", -- command to use to open the log buffer
  },
  dev_tools = {
    autostart = false,         -- autostart devtools server if not detected
    auto_open_browser = false, -- Automatically opens devtools in the browser
  },
  outline = {
    open_cmd = "30vnew", -- command to use to open the outline buffer
    auto_open = false    -- if true this will open the outline automatically when it is first populated
  },
  lsp = {
    on_attach = on_attach,
    color = {                 -- show the derived colours for dart variables
      enabled = true,         -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
      background = false,     -- highlight the background
      background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
      foreground = false,     -- highlight the foreground
      virtual_text = true,    -- show the highlight using virtual text
      virtual_text_str = "■", -- the virtual text character to highlight
    },                        -- https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md#client-workspace-configuration
    settings = {
      showTodos = true,
      completeFunctionCalls = true,
      renameFilesWithClasses = "prompt", -- "always"
      enableSnippets = true,
    }
  }
}
