return {
	{
		"folke/ts-comments.nvim",
		event = "VeryLazy",
		opts = {
			lang = {
				devicetree = { "// %s", "/* %s */" },
			},
		},
	},

	{
		"numToStr/Comment.nvim",
		enabled = false,
		event = "LazyFile",
		config = function()
			vim.api.nvim_command('set commentstring=// %s')
			local ft = require('Comment.ft')
			ft.set('dts','//%s')

			local api = require("Comment.api")
			vim.keymap.set("n", "<leader>cn", api.locked("comment.linewise.current"), {  nowait = true, desc = "comment linewise" })
			vim.keymap.set("n", "<leader>cu", api.locked("uncomment.linewise.current"), {  nowait = true, desc = "uncomment linewise" })

			-- need move keymap.lua
			-- vim.api.nvim_set_keymap("n", "<C-_>", "<Cmd>lua require('Comment.api').toggle.linewise.current()<CR>", {})
			-- vim.api.nvim_set_keymap("i", "<C-_>", "<Esc>:<C-u>lua require('Comment.api').toggle.linewise.current()<CR>\"_cc", {})
			-- vim.api.nvim_set_keymap("v", "<C-_>", "gc", {})
			-- vim.api.nvim_set_keymap("n", "<C-/>", "<Cmd>lua require('Comment.api').toggle.linewise.current()<CR>", {})
			-- vim.api.nvim_set_keymap("i", "<C-/>", "<Esc>:<C-u>lua require('Comment.api').toggle.linewise.current()<CR>\"_cc", {})
			-- vim.api.nvim_set_keymap("v", "<C-/>", "gc", {})
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
