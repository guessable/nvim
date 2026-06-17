-- settings ---------------------------------------------------------------
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
vim.opt.winborder = "rounded"
local opts = { noremap = true, silent = true }

-- plugins ----------------------------------------------------------------
vim.pack.add({
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/nvimdev/lspsaga.nvim' },
  { src = "https://github.com/mason-org/mason.nvim",           name = "mason" },
  { src = "https://github.com/saghen/blink.cmp",               version = "v1", name = "blink.cmp" },

  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },

  { src = 'https://github.com/folke/noice.nvim' },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },
  { src = 'https://github.com/rcarriga/nvim-notify' },

  { src = "https://github.com/catppuccin/nvim" },
  { src = "https://github.com/akinsho/bufferline.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },

  { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },

  { src = "https://github.com/akinsho/toggleterm.nvim" },
  { src = "https://github.com/rainbowhxch/accelerated-jk.nvim" },
  { src = "https://github.com/karb94/neoscroll.nvim" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/numToStr/Comment.nvim" },
})
vim.keymap.set("n", "U", ":lua vim.pack.update()<CR>", opts)

-- autocmds ---------------------------------------------------------------
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.hl.on_yank { higroup = "IncSearch", timeout = 150 } end,
})
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd("normal! g'\"")
    end
  end,
})
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.cpp", "*.lua", "*.hpp", "*.cc", "*.c" },
  callback = function() vim.lsp.buf.format() end
})
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.py",
  command = "silent exec '!python -m black % --line-length 140'",
})

local function insert_banner(lines)
  vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
end

local banner_py = {
  "# ---------------------",
  '#      "   ',
  "#    '':''",
  "#   ___:____      |\\/|",
  "# ,'        `.    \\  /",
  "# |  O        \\___/  |",
  "# ~^~^~^~^~^~^~^~^~^~^",
  "# ---------------------",
  "# @author: τ",
  "",
}

local banner_cpp = {
  "/************************",
  '     "   ',
  "   '':''",
  "  ___:____      |\\/|",
  ",'        `.    \\  /",
  "|  O        \\___/  |",
  "~^~^~^~^~^~^~^~^~^~^",
  "@author: τ",
  "*************************/",
  "",
}

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = { "*.py", "*.jl" },
  callback = function() insert_banner(banner_py) end,
})
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.cpp",
  callback = function() insert_banner(banner_cpp) end,
})

-- keymaps ----------------------------------------------------------------
vim.keymap.set("n", "<C-q>", ":q!<CR>", opts)
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
for i = 1, 9 do
  vim.keymap.set("n", "<Leader>" .. i, "<Cmd>BufferLineGoToBuffer " .. i .. "<CR>", opts)
end

-- telescope
vim.keymap.set("n", "<Leader>fh", ":Telescope oldfiles<CR>", opts)
vim.keymap.set("n", "<Leader>fw", ":Telescope live_grep<CR>", opts)
vim.keymap.set("n", "<Leader>ff", ":Telescope find_files<CR>", opts)
vim.keymap.set("n", "<Leader>fb", ":Telescope buffers<CR>", opts)
vim.keymap.set("n", "<Leader>fm", ":Telescope marks<CR>", opts)
vim.keymap.set("n", "<Leader>fj", ":Telescope diagnostics<CR>", opts)
vim.keymap.set("n", "<Leader>fs", ":Telescope lsp_document_symbols<CR>", opts)

-- lspsaga
vim.keymap.set("n", "<Leader>e", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
vim.keymap.set("n", "<Leader>k", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
vim.keymap.set("n", "<Leader>j", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
vim.keymap.set("n", "gD", "<cmd>Lspsaga goto_definition<CR>", opts)
vim.keymap.set("n", "<Leader>ft", "<cmd>Lspsaga term_toggle<CR>", opts)
vim.keymap.set("t", "<Leader>ft", "<cmd>Lspsaga term_toggle<CR>", opts)

-- utils
vim.keymap.set("n", "<Leader>o", ":NvimTreeToggle<CR>", opts)
vim.keymap.set("n", "<C-_>", "<Plug>(comment_toggle_linewise_current)", opts)
vim.keymap.set("x", "<C-_>", "<Plug>(comment_toggle_linewise_visual)", opts)
vim.keymap.set("n", "j", "<Plug>(accelerated_jk_gj)", opts)
vim.keymap.set("n", "k", "<Plug>(accelerated_jk_gk)", opts)

-- plugins config ---------------------------------------------------------
require("catppuccin").setup({
  background = { dark = "macchiato" },
  no_italic = true,
})
vim.cmd.colorscheme "catppuccin"

-- telescope
require("telescope").setup {
  defaults = {
    prompt_prefix = ' ',
    mappings = { i = { ["<Leader>v"] = require("telescope.actions").select_vertical } },
  },
}

-- noice
require("noice").setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = false,
  },
})

-- bufferline
require("bufferline").setup {
  options = {
    numbers = "ordinal",
    tab_size = 10,
    buffer_close_icon = '',
    separator_style = "thick",
    style_preset = {
      require("bufferline").style_preset.no_italic,
      require("bufferline").style_preset.no_bold,
    },
    offsets = { {
      filetype = "NvimTree",
      text = "File Explorer",
      highlight = "Directory",
      text_align = "center",
    } },
  },
}

-- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")
    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    vim.keymap.set("n", "l", api.tree.change_root_to_node, opts("CD"))
    vim.keymap.set("n", "h", api.tree.change_root_to_parent, opts("Up"))
    vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
    vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
    vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
    vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
    vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
    vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
  end,
  view = { width = 30 },
  renderer = { group_empty = true },
  filters = { dotfiles = true },
})

-- LSP
require("mason").setup({
  ui = { icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" } },
})
vim.lsp.enable({ "ty" })
vim.lsp.enable({ "clangd" })
vim.lsp.enable({ "lua_ls" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    local map_opts = { buffer = ev.buf }
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, map_opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, map_opts)
  end,
})
vim.diagnostic.config({
  virtual_text = false,
  signs = false,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

-- lspsaga
require("lspsaga").setup({})

-- blink
require("blink.cmp").setup({
  completion = {
    documentation = { auto_show = true, window = { border = "single", scrollbar = false } },
    menu = { border = "single", auto_show = true, auto_show_delay_ms = 0, scrollbar = false },
  },
  keymap = {
    preset = "none",
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<Tab>"] = { "select_and_accept", "fallback" },
    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
    ["<C-n>"] = { "select_next", "fallback_to_mappings" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },
    ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
  },
  signature = { enabled = true },
  fuzzy = { implementation = "lua" },
  cmdline = { completion = { menu = { auto_show = true } } },
  sources = {
    providers = {
      snippets = {
        score_offset = 1000,
        should_show_items = function(ctx) return ctx.trigger.initial_kind ~= "trigger_character" end,
      },
    },
  },
})

-- statusline
require("evil")

-- toggleterm
require("toggleterm").setup {
  size = 80,
  open_mapping = [[<Leader>tv]],
  direction = "vertical",
}

-- utils
require("Comment").setup()
require("nvim-autopairs").setup()
require("neoscroll").setup({ mappings = { "<C-b>", "<C-f>" } })
