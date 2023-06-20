-- setting
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

vim.cmd [[au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}]]
vim.cmd [[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]
vim.cmd [[au BufWritePost *.py silent exec "!python3 -m black %"]]

-- plugins
require("plugins")
require("core.ui")
require("core.statusline")
require("core.lsp")
require("core.cmp")
require("core.utils")
require("core.keymap")
