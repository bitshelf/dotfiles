return {
	setup = function(lspconfig, lsp)
		lspconfig.clangd.setup({
			on_attach = function()
			end,
			cmd = {
			  "clangd",
			  "--background-index",
			  "--header-insertion=never",
			  "--all-scopes-completion",
			  "--completion-style=detailed",
			};
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto","dts", },
		})
	end,
		single_file_support = true,
}
