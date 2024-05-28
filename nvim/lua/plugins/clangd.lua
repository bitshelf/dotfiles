return {
  {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
		-- Ensure mason installs the server
			clangd = {
				cmd = {
					"clangd",
					"--background-index",
					-- "--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--function-arg-placeholders",
					"--fallback-style=llvm",
					"--header-insertion=never",
					"--all-scopes-completion",
					"--completion-style=detailed",
					"--offset-encoding=utf-16",
					"--pch-storage=memory",
					-- 启用这项时，补全函数时，将会给参数提供占位符，键入后按 Tab 可以切换到下一占位符
					"--function-arg-placeholders=false",
					"-j=32",
				},
			},
		},
	},
  },
}
