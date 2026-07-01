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
vim.o.smoothscroll = true

-- plugins ----------------------------------------------------------------
vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvimdev/lspsaga.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim", name = "mason" },
	{ src = "https://github.com/saghen/blink.cmp", version = "v1", name = "blink.cmp" },
	{ src = "https://github.com/stevearc/conform.nvim" },

	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/Shatur/neovim-session-manager" },

	{ src = "https://github.com/goolord/alpha-nvim" },
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/romus204/tree-sitter-manager.nvim" },

	{ src = "https://github.com/akinsho/bufferline.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
	{ src = "https://github.com/rachartier/tiny-cmdline.nvim" },

	-----------------------------------------------------
	{ src = "https://github.com/nvim-mini/mini.nvim" },
})
vim.keymap.set("n", "U", "<cmd>lua vim.pack.update()<CR>", { silent = true, noremap = true })

-- autocmds ---------------------------------------------------------------
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, { command = "checktime" })
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
			vim.cmd("normal! g'\"")
		end
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r" })
	end,
})
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		if vim.bo.buftype == "terminal" then
			vim.cmd.startinsert()
		end
	end,
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
local header_cpp = {
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
	pattern = { "*.py" },
	callback = function()
		insert_header(header_py)
	end,
})
vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = { "*.cpp", "*.cc", "*.hpp", "*.h", "*.c" },
	callback = function()
		insert_header(header_cpp)
	end,
})

-- keymaps ----------------------------------------------------------------
local opts = { silent = true, noremap = true }
vim.keymap.set("n", "<C-q>", "<cmd>qa!<CR>", opts)
vim.keymap.set("n", "<Leader>bd", "<cmd>bd<CR>", opts)
vim.keymap.set("n", "<Leader>nh", "<cmd>nohl<CR>", opts)
vim.keymap.set("n", "<C-s>", "<cmd>silent w<CR>", opts)
vim.keymap.set("i", "<C-s>", "<Esc><cmd>silent w<CR>a", opts)

vim.keymap.set("n", "<C-e>", "<End>", opts)
vim.keymap.set("i", "<C-e>", "<Esc>$a", opts)
vim.keymap.set("n", "<C-o>", "<C-w>o", opts)

vim.keymap.set("t", ":q", "<C-\\><C-n>:bdelete! %<CR>", opts)
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", opts)

for i, char in ipairs({ "l", "h", "j", "k" }) do
	vim.keymap.set("n", "<C-" .. char .. ">", "<C-w>" .. char, opts)
	if char ~= "l" then
		vim.keymap.set("t", "<C-" .. char .. ">", "<C-\\><C-n><C-w>" .. char, opts)
	end
end

-- tab
for i = 1, 9 do
	vim.keymap.set("n", "<Leader>t" .. i, i .. "gt", opts)
	vim.keymap.set("t", "<Leader>t" .. i, "<C-\\><C-n>" .. i .. "gt", opts)
end

-- tab terminal
vim.keymap.set("n", "<Leader>tt", "<cmd>tab terminal<CR>i", opts)

-- run python code
local function run_python()
	local file = vim.api.nvim_buf_get_name(0)
	vim.cmd("botright split")
	vim.cmd("resize 14")
	vim.cmd("terminal python " .. vim.fn.shellescape(file))
	vim.cmd("startinsert")
end
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.keymap.set("n", "<leader>r", run_python, { buffer = true, desc = "Run Python Code" })
	end,
})

-- Bufferline
for i = 1, 9 do
	vim.keymap.set("n", "<Leader>b" .. i, "<Cmd>BufferLineGoToBuffer " .. i .. "<CR>", opts)
end

-- Telescope
vim.keymap.set("n", "<Leader>ff", "<cmd>Telescope builtin theme=dropdown previewer=false<CR>", opts)
vim.keymap.set("n", "<Leader>fh", "<cmd>Telescope oldfiles<CR>", opts)
vim.keymap.set("n", "<Leader>fd", "<cmd>Telescope find_files<CR>", opts)
vim.keymap.set("n", "<Leader>fb", "<cmd>Telescope buffers theme=dropdown previewer=false<CR>", opts)
vim.keymap.set("n", "<C-f>", "<cmd>Telescope live_grep<CR>", opts)

-- Session
vim.keymap.set("n", "<Leader>ss", "<cmd>SessionManager<CR>", opts)
vim.keymap.set("n", "<Leader>fp", "<cmd>SessionManager load_session<CR>", opts)

-- Lspsaga
vim.keymap.set("n", "<Leader>e", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
vim.keymap.set("n", "<Leader>k", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
vim.keymap.set("n", "<Leader>j", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
vim.keymap.set("n", "gD", "<cmd>Lspsaga goto_definition<CR>", opts)
vim.keymap.set({ "n", "t" }, "<Leader>tf", "<cmd>Lspsaga term_toggle<CR>", opts)

-- NvimTree
vim.keymap.set("n", "<C-b>", "<cmd>NvimTreeToggle ./<CR>", opts)

-- plugins config ---------------------------------------------------------
require("tokyonight").setup({
	style = "moon", -- moon, storm
	styles = { comments = { italic = false }, keywords = { italic = false } },
})
vim.cmd([[colorscheme tokyonight]])
require("dolphin_tri") -- statusline

-- tree-sitter
require("tree-sitter-manager").setup({
	auto_install = true,
	noauto_install = { "c", "lua", "markdown", "markdown_inline" },
})

-- mini
require("mini.notify").setup()
require("mini.pairs").setup()
require("mini.comment").setup({ mappings = { comment_line = "<C-_>", comment_visual = "<C-_>" } })
require("mini.indentscope").setup({ draw = { delay = 40 } })
require("mini.animate").setup() -- <C-u>, <C-d>
require("mini.jump2d").setup({ mappings = { start_jumping = "<CR>" } })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "NvimTree", "alpha", "terminal" },
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
})

-- formatter
require("conform").setup({
	formatters_by_ft = { lua = { "stylua" }, python = { "black" }, cpp = { "clang-format" } },
	format_on_save = { lsp_format = "fallback", timeout_ms = 500 },
	formatters = { black = { prepend_args = { "--line-length", "140" } } },
})

-- telescope
local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		sorting_strategy = "ascending",
		prompt_prefix = " ",
		mappings = { i = { ["<Leader>v"] = actions.select_vertical } },
		layout_config = { horizontal = { prompt_position = "top" } },
	},
	extensions = { ["ui-select"] = { require("telescope.themes").get_dropdown({}) } },
})
require("telescope").load_extension("ui-select")

-- Session
local config = require("session_manager.config")
require("session_manager").setup({ autoload_mode = config.AutoloadMode.Disabled }) -- AutoloadMode.LastSession

-- bufferline
require("bufferline").setup({
	options = {
		numbers = "ordinal",
		tab_size = 10,
		buffer_close_icon = "",
		separator_style = "thick",
		style_preset = {
			require("bufferline").style_preset.no_italic,
			require("bufferline").style_preset.no_bold,
		},
		offsets = {
			{
				filetype = "neo-tree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "center",
			},
		},
		custom_filter = function(bufnr)
			local bt = vim.bo[bufnr].buftype
			return bt ~= "terminal" and bt ~= "help"
		end,
	},
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
	view = { width = 35 },
	renderer = {
		group_empty = true,
		indent_markers = { enable = true },
		icons = { glyphs = { folder = { arrow_closed = "", arrow_open = "" } } },
	},
	filters = { dotfiles = true },
})

-- LSP
require("mason").setup({
	ui = { icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" } },
})
vim.lsp.enable({ "ty" }) -- python
vim.lsp.enable({ "clangd" }) -- cpp
vim.lsp.enable({ "lua_ls" }) -- lua

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

-- tiny-inline
require("tiny-inline-diagnostic").setup({
	options = { add_messages = { display_count = true }, multilines = { enabled = true } },
})
vim.o.cmdheight = 0
require("tiny-cmdline").setup({ width = { value = "35%" }, title = { enabled = true } })

-- lspsaga
require("lspsaga").setup()

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
				should_show_items = function(ctx)
					return ctx.trigger.initial_kind ~= "trigger_character"
				end,
			},
		},
	},
})

-- dashboard
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
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
	")`. _ _  _Ocean_       `-       ..  - .    . - ~ ~ .    \\    ~-` ` `  `. _",
}
dashboard.section.buttons.val = {
	dashboard.button("<Leader> f p", "  Load session", "<cmd>SessionManager load_session<CR>"),
	dashboard.button("<Leader> f f", "  Telescope", "<cmd>Telescope builtin theme=dropdown previewer=false<CR>"),
	dashboard.button("<Leader> s s", "  Session", "<cmd>SessionManager<CR>"),
	dashboard.button("<Leader> f d", "  Find files", "<cmd>Telescope find_files<CR>"),
	dashboard.button("<Leader> f h", "  History", "<cmd>Telescope oldfiles<CR>"),
	dashboard.button("<Leader> t t", "  Term", "<cmd>tab terminal<CR>i"),
	dashboard.button("<Leader> c f", "  Config", ":e ~/.config/nvim/init.lua<CR>"),
	dashboard.button("<Leader> c h", "  Checkhealth", ":checkhealth<CR>"),
	dashboard.button("q", "  Quit", ":qa!<CR>"),
}
dashboard.section.footer.val = { "-Δu = f" }
alpha.setup(dashboard.config)
