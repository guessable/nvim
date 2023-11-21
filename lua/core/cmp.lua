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
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        if #cmp.get_entries() == 1 then
          cmp.confirm({ select = true })
        else
          cmp.select_next_item()
        end
      elseif snippy.can_expand_or_advance() then
      elseif has_words_before() then
        cmp.complete()
        if #cmp.get_entries() == 1 then
          cmp.confirm({ select = true })
        end
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
