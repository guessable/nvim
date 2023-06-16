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
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',

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
    dependencies = {
      'nvim-lua/plenary.nvim',
      'debugloop/telescope-undo.nvim'
    }
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  {
    'nvim-treesitter/nvim-treesitter',
    cmd = 'TSUpdate'
  },
  'HiPhish/nvim-ts-rainbow2',

  'goolord/alpha-nvim',
  'rebelot/kanagawa.nvim',
  'akinsho/bufferline.nvim',
  'nvim-lualine/lualine.nvim',
  'lukas-reineke/indent-blankline.nvim',

  'folke/trouble.nvim',
  'karb94/neoscroll.nvim',
  'CRAG666/code_runner.nvim',
  'rainbowhxch/accelerated-jk.nvim',
  'akinsho/toggleterm.nvim',
  'windwp/nvim-autopairs',
  {
    'lervag/vimtex',
    ft = 'tex'
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
    end
  },
  {
    'phaazon/hop.nvim',
    config = function()
      require("hop").setup()
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
