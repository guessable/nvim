-- colorscheme
require('kanagawa').setup({
  commentStyle = { italic = false },
  keywordStyle = { italic = false },
  typeStyle = { bold = false },
  functionStyle = { bold = true },
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none",
        }
      }
    },
  },
  overrides = function(colors)
    return {
      ["@variable.builtin"] = { fg = colors.theme.syn.special2, italic = false },
      NvimTreeNormal = { bg = '#1C1C1C' },
    }
  end,
})
require("kanagawa").load("wave")

-- gruvbox
require("gruvbox").setup({
  italic = {
    strings = false,
    emphasis = false,
    comments = false,
    operators = false,
    folds = false,
  },
  overrides = {
    WinSeparator = {fg = "#000000"}
  },
  contrast = "hard",
})
vim.cmd("colorscheme gruvbox")

-- treesitter
require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "python", "cpp", "lua", "julia" },
  highlight = {
    enable = true,
  },
  indent = { enable = true },
  context_commentstring = { enable = true, enable_autocmd = false },
  matchup = { enable = true },
}

-- bufferline
local bufferline = require('bufferline')
bufferline.setup {
  options = {
    numbers = "ordinal",
    tab_size = 10,
    buffer_close_icon = '',
    separator_style = "thick",
    style_preset = {
      bufferline.style_preset.no_italic,
      bufferline.style_preset.no_bold
    },
    offsets = { {
      filetype = "NvimTree",
      text = "File Explorer",
      highlight = "Directory",
      text_align = "center"
    }
    }
  }
}

-- dashboard
local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'
dashboard.section.header.val = {
  "                                      _",
  "                               _.-~~.)",
  "         _.--~~~~~---....__  .' . .,'",
  "       ,'. . . . . . . . . .~- ._ (",
  "      ( .. .g. . . . . . . . . . .~-._",
  "   .~__.-~    ~`. . . . . . . . . . . -.",
  "   `----..._      ~-=~~-. . . . . . . . ~-.",
  "             ~-._   `-._ ~=_~~--. . . . . .~.",
  "              | .~-.._  ~--._-.    ~-. . . . ~-.",
  "               \\ .(   ~~--.._~'       `. . . . .~-.                ,",
  "                            ~~--.._    `. . . . . ~-.    .- .   ,'/",
  "_  . _ . -~\\        _ ..  _          ~~--.`_. . . . . ~-_     ,-','`  .",
  "              ._           ~                ~--. . . . .~=.-'. /. `",
  "        - . -~            -. _ . - ~ - _   - ~     ~--..__~ _,. /   \\  - ~",
  "               . .. ..                   ~-               ~~_. (  `",
  ")`. _ _  _Seal_       `-       ..  - .    . - ~ ~ .    \\    ~-` ` `  `. _",
}
dashboard.section.buttons.val = {
  dashboard.button("<Leader> f h", "  History", ":Telescope oldfiles<CR>"),
  dashboard.button("<Leader> f f", "  Find", ":Telescope find_files<CR>"),
  dashboard.button("<Leader> f m", "  Marks", ":Telescope marks<CR>"),
  dashboard.button("<Leader> f b", "  Buffers", ":Telescope buffers<CR>"),
  dashboard.button("<Leader> f w", "  Words", ":Telescope live_grep<CR>"),
  dashboard.button("<Leader> f s", "  Symbols", ":Telescope lsp_document_symbols<CR>"),
  dashboard.button("<Leader> f j", "  Diagnostics", ":Telescope diagnostics<CR>"),
  dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
}
dashboard.section.footer.val = {
  "-Δu = f",
}
alpha.setup(dashboard.config)
