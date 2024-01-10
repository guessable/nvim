-- setting
vim.g.mapleader = " "
vim.g.maplocalleader = " "
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
local opts = { noremap = true, silent = true }

-- plugins
require("plugins")
require("lsp")

-- autocmd
vim.cmd [[au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}]]
vim.cmd [[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]
vim.cmd [[au BufWritePost *.py silent exec "!python3 -m black %"]]
vim.cmd [[au BufWritePost *.jl silent exec "lua vim.lsp.buf.format()"]]
vim.cmd [[au BufWritePost *.cpp,*.hpp,*.h,*.cc silent exec "lua vim.lsp.buf.format()"]]

-- keymap
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
vim.keymap.set('n', '<leader>r', ':RunCode<CR>', opts)
vim.keymap.set('n', 'j', '<Plug>(accelerated_jk_gj)', opts)
vim.keymap.set('n', 'k', '<Plug>(accelerated_jk_gk)', opts)
vim.keymap.set("n", "<Leader><Leader>", function()
  local current_window = vim.fn.win_getid()
  require("leap").leap { target_windows = { current_window } }
end)

-- ui
require('kanagawa').setup({
  commentStyle = { italic = false },
  keywordStyle = { italic = false },
  typeStyle = { bold = false },
  functionStyle = { bold = true },
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none",
        }
      }
    },
  },
  overrides = function(colors)
    return {
      ["@variable.builtin"] = { fg = colors.theme.syn.special2, italic = false },
      NvimTreeNormal = { bg = '#1C1C1C' },
    }
  end,
})
require("kanagawa").load("wave")

-- treesitter
require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "python", "cpp", "lua", "julia" },
  highlight = {
    enable = true,
  },
  indent = { enable = true },
  context_commentstring = { enable = true, enable_autocmd = false },
  matchup = { enable = true },
}

-- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
local function on_attach(bufnr)
  local api = require('nvim-tree.api')
  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  vim.keymap.set('n', 'l', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', 'h', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
  vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
end

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  on_attach = on_attach,
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- bufferline
local bufferline = require('bufferline')
bufferline.setup {
  options = {
    numbers = "ordinal",
    tab_size = 10,
    buffer_close_icon = '',
    separator_style = "thick",
    style_preset = {
      bufferline.style_preset.no_italic,
      bufferline.style_preset.no_bold
    },
    offsets = { {
      filetype = "NvimTree",
      text = "File Explorer",
      highlight = "Directory",
      text_align = "center"
    }
    }
  }
}

-- dashboard
local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'
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
dashboard.section.buttons.val = {
  dashboard.button("<Leader> f h", "  History", ":Telescope oldfiles<CR>"),
  dashboard.button("<Leader> f f", "  Find", ":Telescope find_files<CR>"),
  dashboard.button("<Leader> f m", "  Marks", ":Telescope marks<CR>"),
  dashboard.button("<Leader> f b", "  Buffers", ":Telescope buffers<CR>"),
  dashboard.button("<Leader> f w", "  Words", ":Telescope live_grep<CR>"),
  dashboard.button("<Leader> f s", "  Symbols", ":Telescope lsp_document_symbols<CR>"),
  dashboard.button("<Leader> f j", "  Diagnostics", ":Telescope diagnostics<CR>"),
  dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
}
dashboard.section.footer.val = {
  "-Δu = f",
}
alpha.setup(dashboard.config)

-- statusline
require("statusline")
