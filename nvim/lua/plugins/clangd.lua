return {
  {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
		-- Ensure mason installs the server
			clangd = {
				cmd = {
					"clangd",
					-- "--clang-tidy",
					"--pretty",
					"--enable-config",
					"--background-index",
					"--pch-storage=memory",
					"--fallback-style=GNU",
					"--header-insertion=never",
					"--all-scopes-completion",
					"--offset-encoding=utf-16",
					"--completion-style=detailed",
					-- "--query-driver=clang,clang++,gcc,g++",
					-- 启用这项时，补全函数时，将会给参数提供占位符，键入后按 Tab 可以切换到下一占位符
					"--function-arg-placeholders=false",
					-- "-j=32",
				},
				single_file_support = true,
			},
		},
	},
  },
}
