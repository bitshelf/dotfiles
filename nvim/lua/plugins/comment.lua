return {
	-- {
	-- 	"folke/ts-comments.nvim",
	-- 	enabled = vim.fn.has("nvim-0.10.0") == 1,
	-- 	event = "LazyFile",
	-- 	opts = {
	-- 		lang = {
	-- 			devicetree = { "// %s", "/* %s */" },
	-- 		},
	-- 	},

	-- need move keymap.lua
	-- local line_rhs = function()
	-- 	return require('vim._comment').operator() .. '_'
	-- end
	-- vim.keymap.set({ 'n', 'x' }, '<c-/>', line_rhs, { expr = true, desc = 'Toggle comment' })
	-- vim.keymap.set({ 'n', 'x' }, '<c-_>', line_rhs, { expr = true, desc = 'Toggle comment' })

	-- },

	{
		"numToStr/Comment.nvim",
		-- enabled = false,
		event = "LazyFile",
		config = function()
			vim.api.nvim_command('set commentstring=//%s')
			local ft = require('Comment.ft')
			ft.set('dts','//%s')

			local api = require("Comment.api")
			vim.keymap.set("n", "<leader>cn", api.locked("comment.linewise.current"), { buffer = buf, nowait = true, desc = "comment linewise" })
			vim.keymap.set("n", "<leader>cu", api.locked("uncomment.linewise.current"), { buffer = buf, nowait = true, desc = "uncomment linewise" })

			-- need move keymap.lua
			-- vim.keymap.set({'n','i'}, "<c-/>", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", { noremap = true, silent = true, nowait = true, desc = "Toggle Comment line" })
			-- vim.keymap.set("x", "<c-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { noremap = true, silent = true, nowait = true, desc = "Toggle Comment visualmode" })
			-- vim.keymap.set({'n','i'}, "<c-_>", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", { noremap = true, silent = true, nowait = true, desc = "Toggle Comment line" })
			-- vim.keymap.set("x", "<c-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { noremap = true, silent = true, nowait = true, desc = "Toggle Comment visualmode" })


			local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
			vim.keymap.set('x', '<leader>cn', function()
				vim.api.nvim_feedkeys(esc, 'nx', false)
				api.locked('comment.linewise')(vim.fn.visualmode())
			end)
			vim.keymap.set('x', '<leader>cu', function()
				vim.api.nvim_feedkeys(esc, 'nx', false)
				api.locked('uncomment.linewise')(vim.fn.visualmode())
			end)
			vim.keymap.set('x', '<leader>ce', function()
				vim.api.nvim_feedkeys(esc, 'nx', false)
				api.locked('toggle.blockwise')(vim.fn.visualmode())
			end)

			require('Comment').setup({
				padding = true,
				sticky = true,
				---Enable keybindings
				---NOTE: If given `false` then the plugin won't create any mappings
				mappings = {
					---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
					basic = false,
					---Extra mapping; `gco`, `gcO`, `gcA`
					extra = false,
				},
			})
		end
	},
}
