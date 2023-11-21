--
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-q>", ":q<CR>", opts)
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

vim.keymap.set("n", "<Leader>tv", ":vsp term://zsh<CR>:vertical res -14<CR>i", opts)
vim.keymap.set("n", "<Leader>th", ":sp term://zsh<CR>:res -7<CR>i", opts)
vim.keymap.set("t", ":q", "<C-\\><C-n>:bdelete! %<CR>", opts)
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", opts)
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", opts)
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)

-- bufferline
vim.keymap.set("n", "<Leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", opts)
vim.keymap.set("n", "<Leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", opts)
vim.keymap.set("n", "<Leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", opts)
vim.keymap.set("n", "<Leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", opts)
vim.keymap.set("n", "<Leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", opts)
vim.keymap.set("n", "<Leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", opts)
vim.keymap.set("n", "<Leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", opts)
vim.keymap.set("n", "<Leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", opts)
vim.keymap.set("n", "<Leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", opts)

-- telescope
vim.keymap.set('n', '<Leader>fh', ':Telescope oldfiles<CR>', opts)
vim.keymap.set('n', '<Leader>fw', ':Telescope live_grep<CR>', opts)
vim.keymap.set('n', '<Leader>ff', ':Telescope find_files<CR>', opts)
vim.keymap.set('n', '<Leader>fb', ':Telescope buffers<CR>', opts)
vim.keymap.set('n', '<Leader>fm', ':Telescope marks<CR>', opts)
vim.keymap.set('n', '<Leader>fj', ':Telescope diagnostics<CR>', opts)
vim.keymap.set('n', '<Leader>fs', ':Telescope lsp_document_symbols<CR>', opts)

-- utils
vim.keymap.set("n", "<Leader>o", ":NvimTreeToggle<CR>", opts)

vim.keymap.set('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)', opts) -- c-/
vim.keymap.set('x', '<C-_>', '<Plug>(comment_toggle_linewise_visual)', opts)

vim.keymap.set('n', '<Leader>r', ':RunCode<CR>', opts)

vim.keymap.set('n', 'j', '<Plug>(accelerated_jk_gj)', opts)
vim.keymap.set('n', 'k', '<Plug>(accelerated_jk_gk)', opts)

vim.keymap.set("n", "<Leader><Leader>", function()
  local current_window = vim.fn.win_getid()
  require("leap").leap { target_windows = { current_window } }
end)
