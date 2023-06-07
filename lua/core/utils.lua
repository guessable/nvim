-- telescope
local actions = require "telescope.actions"
require('telescope').setup {
  defaults = {
    prompt_prefix = ' ',
    mappings = {
      i = {
        ['<Leader>v'] = actions.select_vertical
      },
    }
  },
  extensions = {
    undo = {

    },
  }
}
require("telescope").load_extension("undo")

-- trouble
require('trouble').setup({
  mode = "document_diagnostics",
  signs = {
    error = "",
    warning = "",
    hint = "",
    information = "",
    other = "﫠"
  },
})

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

-- indentline
vim.g.indent_blankline_filetype = { "python" }
require("indent_blankline").setup {
  show_current_context = true,
}

-- code runner
require('code_runner').setup({
  filetype = {
    python = "python3 -u",
    julia = 'julia'
  }
})

-- toggleterm
require("toggleterm").setup {
  open_mapping = [[<c-t>]],
  direction = 'vertical',
  size = vim.o.columns * 0.392
}

-- scroll
require('neoscroll').setup({
  mappings = { '<C-b>', '<C-f>' },
})
