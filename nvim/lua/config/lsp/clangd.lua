return {
	setup = function(lspconfig, lsp)
		lspconfig.clangd.setup({
			on_attach = function()
			end,
			settings = {
					cmd = {
					  "clangd",
					  "--header-insertion=never",
					  "--all-scopes-completion",
					  "--completion-style=detailed",
					};
					filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto","dts", }
			}
		})
	end
}
