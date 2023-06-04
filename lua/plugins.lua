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
  'williamboman/mason.nvim',
  'neovim/nvim-lspconfig',

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'octaltree/cmp-look',
    }
  },
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',

  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
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

  'windwp/nvim-autopairs',
  'numToStr/Comment.nvim',
  'karb94/neoscroll.nvim',
  'phaazon/hop.nvim',
  'kylechui/nvim-surround',
  'CRAG666/code_runner.nvim',
  'rainbowhxch/accelerated-jk.nvim',
  'akinsho/toggleterm.nvim',
  {
    "folke/which-key.nvim",
    event = "VeryLazy"
  },

  { 'lervag/vimtex', ft = 'tex' }
}

require("lazy").setup(plugins, {
  lockfile = vim.fn.stdpath("config") .. "~/.local/share/nvim/lazy/lazy-lock.json"
})
