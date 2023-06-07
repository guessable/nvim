--
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "<C-q>", ":q<CR>", opts)
keymap.set("n", "<Leader>nh", ":nohl<CR>", opts)
keymap.set("n", "<Leader>bd", ":bd<CR>", opts)
keymap.set("n", "<C-s>", ":w<CR>", opts)
keymap.set("i", "<C-s>", "<Esc>:w<CR>a", opts)

keymap.set("n", "<Up>", ":res +5<CR>", opts)
keymap.set("n", "<Down>", ":res -5<CR>", opts)
keymap.set("n", "<Left>", ":vertical resize-5<CR>", opts)
keymap.set("n", "<Right>", ":vertical resize+5<CR>", opts)

keymap.set("n", "<C-a>", "<Home>", opts)
keymap.set("n", "<C-e>", "<End>", opts)
keymap.set("i", "<C-a>", "<Esc>0i", opts)
keymap.set("i", "<C-e>", "<Esc>$a", opts)
keymap.set("i", "<C-b>", "<Left>", opts)
keymap.set("i", "<C-f>", "<Right>", opts)

keymap.set("n", "<C-l>", "<C-w>l", opts)
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-o>", "<C-w>o", opts)

keymap.set("n", "<Leader>tv", ":vsp term://zsh<CR>:vertical res -14<CR>i", opts)
keymap.set("n", "<Leader>th", ":sp term://zsh<CR>:res -7<CR>i", opts)
keymap.set("t", ":q", "<C-\\><C-n>:bdelete! %<CR>", opts)
keymap.set("t", "<ESC>", "<C-\\><C-n>", opts)
keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", opts)
keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)

-- bufferline
keymap.set("n", "<Leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", opts)
keymap.set("n", "<Leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", opts)
keymap.set("n", "<Leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", opts)
keymap.set("n", "<Leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", opts)
keymap.set("n", "<Leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", opts)
keymap.set("n", "<Leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", opts)
keymap.set("n", "<Leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", opts)
keymap.set("n", "<Leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", opts)
keymap.set("n", "<Leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", opts)

-- telescope
keymap.set('n', '<leader>fh', ':Telescope oldfiles<CR>', opts)
keymap.set('n', '<leader>fw', ':Telescope live_grep<CR>', opts)
keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', opts)
keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', opts)
keymap.set('n', '<leader>fm', ':Telescope marks<CR>', opts)
keymap.set("n", "<leader>fu", ':Telescope undo<CR>', opts)

-- utils
keymap.set('n', '<leader>fj', ':TroubleToggle<CR>', opts)
keymap.set("n", "<Leader>o", ":NvimTreeToggle<CR>", opts)
keymap.set("n", "<Leader>ss", ":HopChar2<CR>", opts)
keymap.set("n", "<Leader>ww", ":HopWord<CR>", opts)

keymap.set('n', '<Leader>cc', '<Plug>(comment_toggle_linewise_current)', opts)
keymap.set('x', '<Leader>cc', '<Plug>(comment_toggle_linewise_visual)', opts)

keymap.set('n', '<leader>r', ':RunCode<CR>', opts)
keymap.set('n', 'j', '<Plug>(accelerated_jk_gj)', opts)
keymap.set('n', 'k', '<Plug>(accelerated_jk_gk)', opts)
