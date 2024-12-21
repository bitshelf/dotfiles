return {
	{
	"williamboman/mason.nvim",
	opts = {
		ensure_installed = {
			"bash-language-server",
			"clangd",
			"lua-language-server",
			"pyright",
			"vtsls"
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			diagnostics = {
				underline = false,
			},

			inlay_hints = {
				enabled = false,
			},
		},
	}
}
