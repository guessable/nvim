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

-- code runner
require('code_runner').setup({
  filetype = {
    python = "python3 -u",
    julia = 'julia',
    tex = 'latexmk -xelatex'
  }
})

-- autopairs
require("nvim-autopairs").setup()
local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')
npairs.add_rules({
  Rule("$", "$", { "tex", "latex" })
})

-- toggleterm
require("toggleterm").setup {
  open_mapping = [[<c-t>]],
  direction = 'vertical',
  size = vim.o.columns * 0.4
}

-- scroll
require('neoscroll').setup({
  mappings = { '<C-b>', '<C-f>' },
})

-- comment
require('Comment').setup()

-- whichkey
require("which-key").setup()

-- hop
require("hop").setup()

-- surround
require("nvim-surround").setup()

-- vimtex
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_syntax_enabled = 0
vim.g.vimtex_compiler_progname = 'nvr'
vim.cmd [[
  let g:vimtex_toc_config = {
  \ 'split_width' : 30,
  \ 'show_help' : 0,
  \ 'show_numbers' : 1,
  \}
]]
