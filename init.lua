-- settings ---------------------------------------------------------------
require("vim._core.ui2").enable({ enable = true })
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.signcolumn = "no"
vim.opt.scrolloff = 7
vim.opt.autochdir = true
vim.opt.autoread = true
vim.opt.mouse:append("a")
vim.opt.cmdheight = 1
vim.opt.winborder = "rounded"
vim.o.whichwrap = vim.o.whichwrap .. "<>,h,l"

vim.opt.shell = "powershell.exe"
vim.opt.shellcmdflag =
"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""

local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", { silent = true }, opts or {}))
end

-- plugins ----------------------------------------------------------------
vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvimdev/lspsaga.nvim" },
  { src = "https://github.com/mason-org/mason.nvim",                  name = "mason" },
  { src = "https://github.com/saghen/blink.cmp",                      version = "v1", name = "blink.cmp" },

  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },

  { src = "https://github.com/catppuccin/nvim" },
  { src = "https://github.com/akinsho/bufferline.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
  { src = "https://github.com/goolord/alpha-nvim" },

  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },

  { src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
  { src = "https://github.com/akinsho/toggleterm.nvim" },
  { src = "https://github.com/rainbowhxch/accelerated-jk.nvim" },
  { src = "https://github.com/karb94/neoscroll.nvim" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/numToStr/Comment.nvim" },
})
map("n", "U", ":lua vim.pack.update()<CR>")

-- autocmds ---------------------------------------------------------------
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.hl.on_yank { higroup = "IncSearch", timeout = 150 } end,
})
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, { command = "checktime" })
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd("normal! g'\"")
    end
  end,
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.jl", "*.lua" },
  callback = function() vim.lsp.buf.format() end,
})
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.py",
  command = "silent exec '!python -m black % --line-length 140'",
})

-- header
local function insert_header(lines)
  vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
end

local header_py = {
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
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = { "*.py", "*.jl" }, callback = function() insert_header(header_py) end
})


-- keymaps ----------------------------------------------------------------
map("n", "<C-q>", ":qa!<CR>")
map("n", "<Leader>nh", ":nohl<CR>")
map("n", "<Leader>bd", ":bd<CR>")
map("n", "<C-s>", ":w<CR>")
map("i", "<C-s>", "<Esc>:w<CR>a")

map("n", "<Up>", ":res +5<CR>")
map("n", "<Down>", ":res -5<CR>")
map("n", "<Left>", ":vertical resize-5<CR>")
map("n", "<Right>", ":vertical resize+5<CR>")

map("n", "<C-a>", "<Home>")
map("n", "<C-e>", "<End>")
map("i", "<C-a>", "<Esc>0i")
map("i", "<C-e>", "<Esc>$a")
map("i", "<C-b>", "<Left>")
map("i", "<C-f>", "<Right>")

map("n", "<C-l>", "<C-w>l")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-o>", "<C-w>o")

map("t", ":q", "<C-\\><C-n>:bdelete! %<CR>")
map("t", "<ESC>", "<C-\\><C-n>")
map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")

-- Bufferline
for i = 1, 9 do
  map("n", "<Leader>" .. i, "<Cmd>BufferLineGoToBuffer " .. i .. "<CR>")
end

-- telescope
map("n", "<Leader>ff", ":Telescope<CR>")
map("n", "<Leader>fh", ":Telescope oldfiles<CR>")
map("n", "<Leader>fw", ":Telescope live_grep<CR>")

-- Lspsaga
map("n", "<Leader>e", "<cmd>Lspsaga show_cursor_diagnostics<CR>")
map("n", "<Leader>k", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
map("n", "<Leader>j", "<cmd>Lspsaga diagnostic_jump_next<CR>")
map("n", "K", "<cmd>Lspsaga hover_doc<CR>")
map("n", "gd", "<cmd>Lspsaga peek_definition<CR>")
map("n", "gD", "<cmd>Lspsaga goto_definition<CR>")

-- Utils
map("n", "<Leader>o", ":NvimTreeToggle<CR>")
map("n", "<C-_>", "<Plug>(comment_toggle_linewise_current)")
map("x", "<C-_>", "<Plug>(comment_toggle_linewise_visual)")
map("n", "j", "<Plug>(accelerated_jk_gj)")
map("n", "k", "<Plug>(accelerated_jk_gk)")

-- plugins config ---------------------------------------------------------
require("catppuccin").setup({
  background = { dark = "macchiato" },
  no_italic = true,
})
vim.cmd.colorscheme "catppuccin"

-- telescope
local actions = require "telescope.actions"
require('telescope').setup {
  defaults = {
    prompt_prefix = ' ',
    mappings = {
      i = {
        ['<Leader>v'] = actions.select_vertical
      },
    },
  },
}

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

-- indent-blankline
require("ibl").setup({
  exclude = { filetypes = { "lua", "cpp" } },
  indent = { char = "┊" },
  scope = {
    show_start = false,
    show_end = false,
    highlight = { "Function", "Label" },
  }
})

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
vim.lsp.enable({ "julials" })
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
  underline = false,
  update_in_insert = false,
  severity_sort = false,
})

-- inline-diagnostic
require("tiny-inline-diagnostic").setup({
  options = {
    add_messages = {
      display_count = true,
    },
    multilines = {
      enabled = true,
    },
  },
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

-- dashboard
local alpha = require 'alpha'
local dashboard = require 'alpha.themes.startify'
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
dashboard.section.top_buttons.val = {
  dashboard.button("e", "  Telescope", ":Telescope<CR>"),
}
dashboard.section.bottom_buttons.val = {
  dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
}
alpha.setup(dashboard.config)

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

-- statusline
require("evil")
