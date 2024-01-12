-- plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  'neovim/nvim-lspconfig',
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    }
  },
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  {
    'nvim-telescope/telescope.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
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
    end
  },
  {
    'rebelot/kanagawa.nvim',
    priority = 1000
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  {
    'nvim-treesitter/nvim-treesitter',
    cmd = 'TSUpdate'
  },

  'goolord/alpha-nvim',
  'akinsho/bufferline.nvim',
  'nvim-lualine/lualine.nvim',
  'rainbowhxch/accelerated-jk.nvim',

  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("ibl").setup({
        exclude = {filetypes = { "lua","julia","cpp" }},
        indent = {char = "┊" },
        scope = {
         show_start = false,
         show_end = false,
         highlight = { "Function", "Label" },
        }
      })
    end
  },
  {
    'ggandor/leap.nvim',
    config = function()
      require("leap").setup({
        opts = {
          highlight_unlabeled_phase_one_targets = true,
          safe_labels = {},
          labels = { 'a', 'r', 's', 't', 'n', 'e', 'i', 'o', 'w', 'f', 'u', 'y', 'd', 'h' },
        }
      })
      vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
    end
  },
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-t>]],
        direction = 'vertical',
        size = 90,
        highlights = {
          Normal = { link = 'NormalTerm'  }
        },
      })
    end
  },
  {
    'karb94/neoscroll.nvim',
     config = function()
      require('neoscroll').setup({
        mappings = { '<C-b>', '<C-f>' },
      })
     end
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  {
    'kylechui/nvim-surround',
    config = function()
      require("nvim-surround").setup()
    end
  },
}
require("lazy").setup(plugins, {
  lockfile = vim.fn.stdpath("config") .. "~/.local/share/nvim/lazy/lazy-lock.json"
})
