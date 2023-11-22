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

local function lsp_icon()
  return ' LSP:'
end

local function infinity()
  return ' '
end

local function dir()
  return " " .. vim.fn.expand('%:p:h:t')
end

local function lsp()
  local msg = 'No Active Lsp'
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.get_active_clients()
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
end

require('lualine').setup {
  options = {
    theme = theme,
    component_separators = '',
    section_separators = { left = '' },
    disabled_filetypes = {
      statusline = { 'NvimTree', 'alpha', 'toggleterm', 'vimtex-toc' },
    },
  },
  sections = {
    lualine_a = {
      { Logo, separator = { right = '' }, colors = { fg = '#080808' } },
    },
    lualine_b = { dir },
    lualine_c = { { 'diagnostics', symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' } } },
    lualine_x = { 'branch' },
    lualine_y = {},
    lualine_z = {
      { lsp_icon, separator = { left = '' },                          color = { bg = colors.blue } },
      { lsp, color = { bg = colors.transparent, fg = colors.white } },
    },
  },
  inactive_sections = {
    lualine_a = { { infinity, color = { bg = "#008B8B", fg = colors.black }, separator = { right = '' } } },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { { 'filename', color = { bg = "#008B8B", fg = colors.black }, separator = { left = '' } } },
  },
  tabline = {},
  extensions = {},
}
