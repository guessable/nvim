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

-- indentline
vim.g.indent_blankline_filetype = { "python" }
require("indent_blankline").setup({
  show_current_context = true,
})

-- leap
require("leap").setup({
  opts = {
    highlight_unlabeled_phase_one_targets = true,
    safe_labels = {},
    labels = { 'a', 'r', 's', 't', 'n', 'e', 'i', 'o', 'w', 'f', 'u', 'y', 'd', 'h' },
  }
})
vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })

-- code runner
require('code_runner').setup({
  filetype = {
    python = "python3 -u",
    julia = 'julia'
  }
})

-- toggleterm
require("toggleterm").setup({
  open_mapping = [[<c-t>]],
  direction = 'vertical',
  size = 85
})

-- scrollbar
require("scrollbar").setup({
  show = true,
  show_in_active_only = true,
  set_highlights = true,
  folds = 1000,
  max_lines = false,
})
