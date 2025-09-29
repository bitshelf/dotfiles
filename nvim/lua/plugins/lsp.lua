return {
	{
	"mason-org/mason.nvim",
	opts = {
		ensure_installed = {
			"bash-language-server",
			"clangd",
			"lua-language-server",
			"rust-analyzer",
			"starpls",
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
