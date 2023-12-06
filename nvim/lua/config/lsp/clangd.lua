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
			  "--pch-storage=memory",
			  -- 启用这项时，补全函数时，将会给参数提供占位符，键入后按 Tab 可以切换到下一占位符
			  "--function-arg-placeholders=false",
			  "--log=verbose",
			  "-j=20",
			};
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto","dts", },
		})
	end,
		single_file_support = true,
}
