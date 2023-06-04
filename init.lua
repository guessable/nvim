-- setting
local opt = vim.opt

opt.autochdir = true
opt.autoread = true
opt.relativenumber = true
opt.number = true
opt.expandtab = true
opt.autoindent = true
opt.splitright = true
opt.splitbelow = true
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.signcolumn = "no"
opt.scrolloff = 7
opt.tabstop = 2
opt.shiftwidth = 2
opt.mouse:append("a")

vim.cmd [[au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}]]
vim.cmd [[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]
vim.cmd [[au BufWritePost *.py silent exec "!python3 -m black %"]]

-- plugins
require("plugins")
require("core.ui")
require("core.telescope")
require("core.line")
require("core.lsp")
require("core.cmp")
require("core.utils")
require("core.keymap")
