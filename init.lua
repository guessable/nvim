-- setting
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "
vim.opt.autochdir = true
vim.opt.autoread = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.signcolumn = "no"
vim.opt.scrolloff = 7
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.mouse:append("a")
vim.opt.cmdheight = 1
local opts = { noremap = true, silent = true }

-- plugins
require("plugins")

-- autocmd
vim.cmd [[au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}]]
vim.cmd [[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]
vim.cmd [[au BufWritePost *.cpp,*.hpp,*.h,*.cc silent exec "lua vim.lsp.buf.format()"]]
vim.cmd [[au BufWritePost *.jl silent exec "lua vim.lsp.buf.format()"]]
vim.cmd [[au BufWritePost *.py silent exec "!python3 -m black %"]]

-- keymap
vim.keymap.set("n", "<C-q>", ":q<CR>", opts)
vim.keymap.set("n", "<Leader>nh", ":nohl<CR>", opts)
vim.keymap.set("n", "<Leader>bd", ":bd<CR>", opts)
vim.keymap.set("n", "<C-s>", ":w<CR>", opts)
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", opts)

vim.keymap.set("n", "<Up>", ":res +5<CR>", opts)
vim.keymap.set("n", "<Down>", ":res -5<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize-5<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize+5<CR>", opts)

vim.keymap.set("n", "<C-a>", "<Home>", opts)
vim.keymap.set("n", "<C-e>", "<End>", opts)
vim.keymap.set("i", "<C-a>", "<Esc>0i", opts)
vim.keymap.set("i", "<C-e>", "<Esc>$a", opts)
vim.keymap.set("i", "<C-b>", "<Left>", opts)
vim.keymap.set("i", "<C-f>", "<Right>", opts)

vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-o>", "<C-w>o", opts)

vim.keymap.set("t", ":q", "<C-\\><C-n>:bdelete! %<CR>", opts)
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", opts)
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", opts)
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)

-- bufferline
vim.keymap.set("n", "<Leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", opts)
vim.keymap.set("n", "<Leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", opts)
vim.keymap.set("n", "<Leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", opts)
vim.keymap.set("n", "<Leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", opts)
vim.keymap.set("n", "<Leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", opts)
vim.keymap.set("n", "<Leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", opts)
vim.keymap.set("n", "<Leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", opts)
vim.keymap.set("n", "<Leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", opts)
vim.keymap.set("n", "<Leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", opts)

-- telescope
vim.keymap.set('n', '<Leader>fh', ':Telescope oldfiles<CR>', opts)
vim.keymap.set('n', '<Leader>fw', ':Telescope live_grep<CR>', opts)
vim.keymap.set('n', '<Leader>ff', ':Telescope find_files<CR>', opts)
vim.keymap.set('n', '<Leader>fb', ':Telescope buffers<CR>', opts)
vim.keymap.set('n', '<Leader>fm', ':Telescope marks<CR>', opts)
vim.keymap.set('n', '<Leader>fj', ':Telescope diagnostics<CR>', opts)
vim.keymap.set('n', '<Leader>fs', ':Telescope lsp_document_symbols<CR>', opts)

-- utils
vim.keymap.set("n", "<Leader>o", ":NvimTreeToggle<CR>", opts)
vim.keymap.set('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)', opts) -- c-/
vim.keymap.set('x', '<C-_>', '<Plug>(comment_toggle_linewise_visual)', opts)
vim.keymap.set('n', 'j', '<Plug>(accelerated_jk_gj)', opts)
vim.keymap.set('n', 'k', '<Plug>(accelerated_jk_gk)', opts)

-- ui
require("catppuccin").setup({
  background = {
    dark = "macchiato",
  },
  no_italic = true,
  styles = {
    functions = { "bold" },
  }
})
vim.cmd.colorscheme "catppuccin"

-- treesitter
require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "python", "lua", "cpp", "julia" },
  highlight = {
    enable = true,
  },
  indent = { enable = true },
  context_commentstring = { enable = true, enable_autocmd = false },
  matchup = { enable = true },
}

-- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
local function on_attach(bufnr)
  local api = require('nvim-tree.api')
  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  vim.keymap.set('n', 'l', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', 'h', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
  vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
end

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  on_attach = on_attach,
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

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

-- lsp
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local servers = { "pyright", "clangd", "julials" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
  }
end

vim.keymap.set('n', '<Leader>tt', '<cmd>Lspsaga term_toggle<CR>')
vim.keymap.set('t', '<Leader>tt', '<cmd>Lspsaga term_toggle<CR>')
vim.keymap.set('n', '<Leader>e', '<cmd>Lspsaga show_cursor_diagnostics<CR>',opts)
vim.keymap.set('n', '<Leader>k', '<cmd>Lspsaga diagnostic_jump_prev<CR>',opts)
vim.keymap.set('n', '<Leader>j', '<cmd>Lspsaga diagnostic_jump_next<CR>',opts)
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>',opts)
vim.keymap.set('n', 'gd', '<cmd>Lspsaga peek_definition<CR>',opts)
vim.keymap.set('n', 'gD', '<cmd>Lspsaga goto_definition<CR>',opts)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  end,
})
vim.diagnostic.config({
  virtual_text = false,
  signs = false,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

-- cmp
local cmp = require 'cmp'
local luasnip = require("luasnip")
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
require("luasnip.loaders.from_vscode").load({ paths = "~/.config/nvim/snippets" })

local kind_icons = {
  File = "󰈙",
  Module = "󰏗", -- ""
  Namespace = "󰌗",
  Snippet = "",
  Package = "󰆦",
  Class = "", -- 󰌗 󰠱
  Method = "󰆧",
  Property = "󰜢", --  
  Keyword = "󰌋",
  Field = "", --󰜢" 
  Constructor = "",
  Enum = "󰕘", -- ""
  Interface = "", --  󰕘
  Function = "󰊕",
  Variable = "", -- 󰀫 
  Constant = "󰏿",
  String = "󰉾",
  Number = "󰎠",
  Boolean = "",
  Array = "󰅪",
  Object = "󰅩",
  Key = "󰌋",
  Null = "󰟢", -- 󰢤
  EnumMember = "",
  Struct = "󰙅", -- "󰌗 "
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰊄",
  Text = "󰉿",
  Unit = "󰑭",
  Value = "󰎠",
  Color = "󰏘",
  Reference = "󰈇",
  Folder = "󰉋",
  MarkdownH1 = "󰉫",
  MarkdownH2 = "󰉬",
  MarkdownH3 = "󰉭",
  MarkdownH4 = "󰉮",
  MarkdownH5 = "󰉯",
  MarkdownH6 = "󰉰",
  Call = "󰃷",
  BreakStatement = "󰙧",
  CaseStatement = "󱃙",
  ContinueStatement = "→",
  Copilot = "",
  Declaration = "󰙠",
  Delete = "󰩺",
  DoStatement = "󰑖",
  ForStatement = "󰑖",
  Identifier = "󰀫",
  IfStatement = "󰇉",
  List = "󰅪",
  Log = "󰦪",
  Lsp = "",
  Macro = "󰁌",
  Regex = "",
  Repeat = "󰑖",
  Scope = "󰅩",
  Specifier = "󰦪",
  Statement = "󰅩",
  SwitchStatement = "󰺟",
  Terminal = "",
  Type = "",
  WhileStatement = "󰑖",
}

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    format = function(entry, vim_item)
      local MAX_LABEL_WIDTH = 30
      if #vim_item.abbr > MAX_LABEL_WIDTH then
        vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0, MAX_LABEL_WIDTH) .. "..."
      end
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
      })[entry.source.name]
      return vim_item
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<CR>'] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
  })
})
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' }
  })
})

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
    section_separators = { left = ' ' },
    disabled_filetypes = {
      statusline = { 'NvimTree', 'alpha', 'vimtex-toc', 'VimTex', 'toggleterm' },
    },
  },
  sections = {
    lualine_a = {
      { Logo, separator = { right = ' ' }, colors = { fg = '#080808' } },
    },
    lualine_b = { dir },
    lualine_c = { { 'diagnostics', symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' } } },
    lualine_x = { 'branch', lsp },
    lualine_y = { { location_icon, color = { bg = colors.green, fg = colors.black }, separator = { left = '' } },
      { 'location', color = { bg = colors.transparent, fg = colors.white } } },
    lualine_z = {
      { clock, separator = { left = '' }, color = { bg = colors.blue } },
      { "progress", color = { bg = colors.transparent, fg = colors.white } },
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
