vim.pack.add {
	"https://github.com/catppuccin/nvim",
	"https://github.com/nvimdev/indentmini.nvim",

	{
		version = "main",
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
	}
}

local parsers = {
	"c",
	"cpp",
	"lua",
	"zig",
	"fish",
	"python",
}

local ts = require"nvim-treesitter"
ts.install(parsers)

vim.api.nvim_create_augroup("Treesitter", {})
vim.api.nvim_create_autocmd(
	"FileType",
	{
		pattern = parsers,
		group = "Treesitter",
		callback = function()
			vim.treesitter.start()
			vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	}
)

require "catppuccin".setup {
	flavour = "mocha",
	transparent_background = false,
	float = {
		transparent = false,
		solid = false,
	},
	show_end_of_buffer = false,
	term_colors = true,
	no_italic = false, -- Force no italic
	no_bold = true,
	no_underline = false,
	styles = {
		loops = {},
		types = {},
		strings = {},
		numbers = {},
		booleans = {},
		functions = {},
		variables = {},
		operators = {},
		properties = {},
		keywords = { "italic" },
		comments = { "italic" },
		conditionals = { "italic" },
	},
	lsp_styles = {
		virtual_text = {
			ok = { "italic" },
			hints = { "italic" },
			errors = { "italic" },
			warnings = { "italic" },
			information = { "italic" },
		},
		underlines = {
			ok = { "undercurl" },
			hints = { "undercurl" },
			errors = { "undercurl" },
			warnings = { "undercurl" },
			information = { "undercurl" },
		},
		inlay_hints = {
			background = true,
		},
	},
	integrations = {},
	color_overrides = {},
	custom_highlights = {},
	auto_integrations = false,
	default_integrations = true,
}

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"

require "indentmini".setup()

vim.cmd.highlight('IndentLine guifg=#45475a')
vim.cmd.highlight('IndentLineCurrent guifg=#89b4fa')
