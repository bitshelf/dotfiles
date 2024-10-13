return {
	{
	'williamboman/mason-lspconfig.nvim',
	cmd = "Mason",
	dependencies = { "williamboman/mason.nvim" },
	opts = {
		ensure_installed = {
			"bashls",
			"clangd",
			"lua_ls",
			"pyright",
			"vtsls"
			},
		},
	},

	{
	"neovim/nvim-lspconfig",
	event = "LazyFile",
	opts = {
			diagnostics = {
				underline = false,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
					-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
					-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
					-- prefix = "icons",
				},

				severity_sort = true,
				signs = {
					text = {
					[vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
					[vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
					[vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
					[vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
					},
				},
			},

			inlay_hints = {
				enabled = false,
				exclude = {}, -- filetypes for which you don't want to enable inlay hints
			},

			servers = {
				lua_ls = {
					mason = false,
				}
			},
		},
	}
}
