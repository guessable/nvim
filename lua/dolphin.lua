local lualine = require('lualine')

local colors = {
  bg      = '#202328',
  fg      = '#bbc2cf',
  blue    = '#51afef',
  cyan    = '#008080',
  green   = '#98be65',
  magenta = '#c678dd',
  orange  = '#FF8800',
  red     = '#ec5f67',
  violet  = '#a9a1e1',
  yellow  = '#ECBE7B',
}

local conditions = {
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
}

local function get_root_name()
  local bufname = vim.fn.expand("%:p")
  if bufname ~= "" then
    local git = vim.fs.root(bufname, ".git")
    if git then
      return vim.fs.basename(git)
    end
  end
  return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

-- Config
local config = {
  options = {
    component_separators = '',
    section_separators = '',
    theme = 'auto',
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end


ins_left {
  function()
    return '▊'
  end,
  color = { fg = colors.blue },
  padding = { left = 0, right = 1 },
}

ins_left { 'mode', icon = '',
  color = function()
    local mode_color = {
      n = colors.violet,
      i = colors.blue,
      v = colors.green,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end
}

ins_left { 'progress', icon = '󰦖', color = { fg = colors.magenta, gui = 'bold' } }
ins_left { 'location', icon = '', color = { fg = colors.violet, gui = 'bold' } }

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ', Hint = " " },
  diagnostics_color = {
    error = { fg = colors.red },
    warn = { fg = colors.yellow },
    info = { fg = colors.cyan },
  },
}

ins_left {
  function()
    return '%='
  end,
}

ins_right {
  -- logo
  function()
    return '󱢴 tau'
  end,
  color = { fg = colors.magenta, gui = 'bold' }
}

ins_right {
  function()
    local msg = '󰋶'
    local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
    local clients = vim.lsp.get_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' ',
  color = { fg = colors.violet, gui = 'bold' },
}

ins_right {
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
}

ins_right {
  'diff',
  symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

ins_right {
  function() return "󱉭 " .. get_root_name() end,
  color = { fg = colors.magenta, gui = 'bold' },
}

ins_right {
  function()
    return '▊'
  end,
  color = { fg = colors.blue },
  padding = { left = 1 },
}

lualine.setup(config)
