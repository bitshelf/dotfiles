return {
	setup = function(lspconfig, lsp)
		-- require("rust-tools").setup({
		-- 	lspconfig = true,
		-- })
		-- lspconfig.lua_ls.setup({
		-- 	on_attach = function()
		-- 	end,
		-- 	settings = {
		-- 	  ['rust-analyzer'] = {
		-- 		diagnostics = {
		-- 		  enable = true;
		-- 		}
		-- 	  }
		-- 	}
		-- })
		local rust_tools = require('rust-tools')

		rust_tools.setup({
		  server = {
			on_attach = function()
			  vim.keymap.set('n', '<leader>ca', rust_tools.hover_actions.hover_actions, {buffer = bufnr})
			end
		  }
		})
	end
}
