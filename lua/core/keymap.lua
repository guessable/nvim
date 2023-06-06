--
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local keymap = vim.keymap

keymap.set("n", "<Leader>nh", ":nohl<CR>", { noremap = true, silent = true })

keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { noremap = true, silent = true })

keymap.set("n", "<Up>", ":res +5<CR>", { noremap = true, silent = true })
keymap.set("n", "<Down>", ":res -5<CR>", { noremap = true, silent = true })
keymap.set("n", "<Left>", ":vertical resize-5<CR>", { noremap = true, silent = true })
keymap.set("n", "<Right>", ":vertical resize+5<CR>", { noremap = true, silent = true })

keymap.set("n", "<C-a>", "<Home>", { noremap = true, silent = true })
keymap.set("n", "<C-e>", "<End>", { noremap = true, silent = true })
keymap.set("i", "<C-a>", "<Esc>0i", { noremap = true, silent = true })
keymap.set("i", "<C-e>", "<Esc>$a", { noremap = true, silent = true })
keymap.set("i", "<C-b>", "<Left>", { noremap = true, silent = true })
keymap.set("i", "<C-f>", "<Right>", { noremap = true, silent = true })

keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
keymap.set("n", "<C-o>", "<C-w>o", { noremap = true, silent = true })

keymap.set("n", "<Leader>tv", ":vsp term://zsh<CR>:vertical res -14<CR>i", { noremap = true, silent = true })
keymap.set("n", "<Leader>th", ":sp term://zsh<CR>:res -7<CR>i", { noremap = true, silent = true })
keymap.set("t", ":q", "<C-\\><C-n>:bdelete! %<CR>", { noremap = true, silent = true })
keymap.set("t", "<ESC>", "<C-\\><C-n>", { noremap = true, silent = true })

keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { noremap = true, silent = true })
keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { noremap = true, silent = true })
keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { noremap = true, silent = true })

-- bufferline
keymap.set("n", "<Leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true })
keymap.set("n", "<Leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true })
keymap.set("n", "<Leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true })
keymap.set("n", "<Leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true })
keymap.set("n", "<Leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", { noremap = true, silent = true })
keymap.set("n", "<Leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", { noremap = true, silent = true })
keymap.set("n", "<Leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", { noremap = true, silent = true })
keymap.set("n", "<Leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", { noremap = true, silent = true })
keymap.set("n", "<Leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", { noremap = true, silent = true })

-- telescope
keymap.set('n', '<leader>fh', ':Telescope oldfiles<CR>', { noremap = true, silent = true })
keymap.set('n', '<leader>fw', ':Telescope live_grep<CR>', { noremap = true, silent = true })
keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })
keymap.set('n', '<leader>fj', ':Telescope diagnostics<CR>', { noremap = true, silent = true })
keymap.set('n', '<leader>fm', ':Telescope marks<CR>', { noremap = true, silent = true })

-- utils
keymap.set("n", "<Leader>o", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
keymap.set("n", "<Leader>ss", ":HopChar2<CR>", { noremap = true, silent = true })
keymap.set("n", "<Leader>ww", ":HopWord<CR>", { noremap = true, silent = true })

keymap.set('n', '<Leader>cc', '<Plug>(comment_toggle_linewise_current)', { noremap = true, silent = true })
keymap.set('x', '<Leader>cc', '<Plug>(comment_toggle_linewise_visual)', { noremap = true, silent = true })

keymap.set('n', '<leader>r', ':RunCode<CR>', { noremap = true, silent = true })
keymap.set('n', 'j', '<Plug>(accelerated_jk_gj)', { noremap = true, silent = true })
keymap.set('n', 'k', '<Plug>(accelerated_jk_gk)', { noremap = true, silent = true })
