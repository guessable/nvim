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

-----------------------------------------------------------------
local config = {
  options = {
    theme = 'auto',
  },
  sections = {
    lualine_a = {
      { 'mode', icon = "" }
    },
    lualine_b = {
      {
        function()
          return '󱢴 tau'
        end,
        color = {fg = colors.magenta, gui = 'bold' }
      },
    },
    lualine_c = {
      { 'progress', icon = '󰦖', color = { fg = colors.violet, gui = 'bold' }, separator = '' },
      { 'location', icon = '', color = { fg = colors.violet, gui = 'bold' }, separator = '' },
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ', Hint = " " },
        diagnostics_color = {
          error = { fg = colors.red },
          warn = { fg = colors.yellow },
          info = { fg = colors.cyan },
        },
        separator = ''
      },
    },
    lualine_x = {
      {
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
        separator = ''
      },
      {
        'diff',
        symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.orange },
          removed = { fg = colors.red },
        },
        cond = conditions.hide_in_width,
        separator = ''
      },
      {
        'branch',
        icon = '',
        color = { fg = colors.violet, gui = 'bold' },
        separator = ''
      },
      {
        function() return "󱉭 " .. get_root_name() end,
        color = { fg = colors.magenta, gui = 'bold' },
        separator = ''
      }
    },
    lualine_y = {},
    lualine_z = {
      {function()
        return " " .. os.date("%R")
      end,
      separator = { left = '' }}
    },
  },
}

lualine.setup(config)
