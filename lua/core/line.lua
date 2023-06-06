-- statusline
local colors = {
  blue        = '#61afef',
  cyan        = '#56b6c2',
  black       = '#080808',
  white       = '#c6c6c6',
  red         = '#e86671',
  violet      = '#c678dd',
  grey        = '#303030',
  yellow      = '#FFD700',
  orange      = '#d19a66',
  green       = '#98c379',
  transparent = '#FFFFFF00'
}

local theme = {
  normal = {
    a = { fg = colors.black, bg = colors.red },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.transparent, bg = colors.transparent },
  },

  insert = { a = { fg = colors.black, bg = colors.red } },
  visual = { a = { fg = colors.black, bg = colors.red } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.transparent, bg = colors.transparent },
  },
}

local function Logo()
  return ' CT'
end

local function clock()
  return ' '
end

local function location_icon()
  return ' '
end

local function infinity()
  return ' '
end

local function time()
  return os.date("%R")
end

local function dir()
  return " " .. vim.fn.expand('%:p:h:t')
end

require('lualine').setup {
  options = {
    theme = theme,
    component_separators = '',
    section_separators = { left = ' ' },
    disabled_filetypes = {
      statusline = { 'NvimTree', 'alpha', 'vimtex-toc', 'VimTex', 'toggleterm' },
    },
  },
  sections = {
    lualine_a = {
      { Logo, separator = { right = ' ' }, colors = { fg = '#080808' } },
    },
    lualine_b = { dir },
    lualine_c = { { 'diagnostics', symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' } } },
    lualine_x = { 'branch', 'progress' },
    lualine_y = { { location_icon, color = { bg = colors.green, fg = colors.black }, separator = { left = '' } },
      { 'location',    color = { bg = colors.transparent, fg = colors.white } } },
    lualine_z = {
      { clock, separator = { left = '' },                          color = { bg = colors.blue } },
      { time,  color = { bg = colors.transparent, fg = colors.white } },
    },
  },
  inactive_sections = {
    lualine_a = { { infinity, color = { bg = "#008B8B", fg = colors.black }, separator = { right = '' } } },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { { 'filename', color = { bg = "#008B8B", fg = colors.black }, separator = { left = '' } } },
  },
  tabline = {},
  extensions = {},
}

-- bufferline
local bufferline = require('bufferline')
bufferline.setup {
  options = {
    numbers = "ordinal",
    tab_size = 10,
    buffer_close_icon = '',
    style_preset = {
      bufferline.style_preset.no_italic,
      bufferline.style_preset.no_bold
    },
    offsets = { {
      filetype = "NvimTree",
      text = "File Explorer",
      highlight = "Directory",
      text_align = "center"
    },
      {
        filetype = "vimtex-toc",
        text = "LaTeX TOC",
        highlight = "Directory",
        text_align = "center"
      }
    }
  }
}

-- indentline
vim.cmd [[
  let g:indent_blankline_filetype = ['python']
]]
