-- Package Manager -----------------------------------------------------------------------------------------

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/saghen/blink.cmp", { confirm = false } },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", { confirm = false }, version = "master" },
	{ src = "https://github.com/nvim-mini/mini.hipatterns" },
})

-- Colorschme and Treesitter  -----------------------------------------------------------------------------------------

require("kanagawa").setup({
    undercurl = false,            -- enable undercurls
    commentStyle = { italic = false },
    functionStyle = {},
    keywordStyle = { italic = false },
    statementStyle = { bold = true },

    overrides = function()
      return {
        ["@variable.builtin"] = { italic = false },
      }
    end
})

require("catppuccin").setup({
  no_italic = true,  -- Disable all italics
})

vim.cmd.colorscheme("kanagawa")
vim.cmd("hi Normal guifg=#A3A9C8")
vim.cmd("hi @property guifg=#A3A9C8")
vim.cmd("hi rainbow1 guifg=#769589")
vim.cmd("hi String guifg=#769589")

require("nvim-treesitter.install").update("all")
require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "bash", "yaml" },
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

-- Comments Engine  ----------------------------------------------------------------------------------------

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
	highlighters = {
		-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

		-- Highlight hex color strings (`#rrggbb`) using that color
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})

-- Completion Engine  ----------------------------------------------------------------------------------------

require("blink.cmp").setup({
	keymap = {
		preset = "super-tab",
		["<C-k>"] = { "select_prev" },
		["<C-j>"] = { "select_next" },
	},
	fuzzy = {
		implementation = "lua",
	},
})

-- Basic Keymaps -----------------------------------------------------------------------------------------

vim.g.mapleader = " "
local m = vim.keymap.set

m("n", "q", ":q!<CR>")
m("n", "a", "A")
m("n", "<leader>w", ":w!<CR>")
m("n", "<BS>", ":noh<CR>")
m("n", "1", ":bp<cr>")
m("n", "2", ":bn<cr>")
m("i", "jj", "<Esc>")

-- Neovim Keymaps -----------------------------------------------------------------------------------------

m("n", "<leader>e", ":Oil<CR>")
m("n", "<leader>f", ":FzfLua files<CR>")
m("n", "<leader>r", ":FzfLua live_grep<CR>")
m("n", "lf", vim.lsp.buf.format)
m("n", "gd", vim.lsp.buf.definition)
m("n", "<leader>wd", vim.diagnostic.open_float)
m("n", "<leader>pu", vim.pack.update)
m("v", "<leader>fd", "zf")
m("n", "<leader>fa", "za")
m("v", "<C-_>", "gc", { remap = true })

-- Basic Options -----------------------------------------------------------------------------------------

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.hidden = true

vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showcmd = false

-- Neovim Options -----------------------------------------------------------------------------------------

vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.guicursor = "n-i-v:ver25"
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.laststatus = 0


-- Cursor Fix -----------------------------------------------------------------------------------------
vim.api.nvim_create_autocmd({"VimLeave", "VimSuspend"}, {
  callback = function()
    vim.opt.guicursor = "a:ver25"
  end,
})

-- File Explorer  -----------------------------------------------------------------------------------------

require("oil").setup({
	view_options = {
		show_hidden = true,
	},
	skip_confirm_for_simple_edits = true,
	prompt_save_on_select_new_entry = false,
})

-- LSP -----------------------------------------------------------------------------------------

require("mason").setup()
require("mason-lspconfig").setup()

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = {
					"vim",
					"require",
				},
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

vim.lsp.config("azure_pipelines_ls", {
	cmd = { "azure-pipelines-language-server", "--stdio" },
	root_markers = { ".git" },
	filetypes = { "yaml" },
	settings = {
		yaml = {
			schemaStore = { enable = false },
			schemas = {
				-- Azure Pipelines schema (VS Code extension repo, branch: main)
				["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/main/service-schema.json"] = {
					"*.yaml",
				},
			},
			validate = true,
			completion = true,
			hover = true,
		},
	},
})
