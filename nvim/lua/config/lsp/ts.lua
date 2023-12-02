return {
	setup = function(lspconfig, lsp)
		lspconfig.tsserver.setup({
			autostart = false,
			on_attach = function()
			end,
			filetypes = {}
		})
	end
}
