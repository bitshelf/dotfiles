return {
	--  {
	--    "echasnovski/mini.comment",
	-- version = '*',
	--    opts = {
	--      mappings = {
	--			comment_line = "<C-_>",
	-- 			comment_visual = "<C-_>",
	-- 			textobject = "<C-_>",
	--      },
	--    },
	--    config = function(_, opts)
	--      vim.schedule(function()
	--        require("mini.comment").setup(opts)
	--      end)
	--    end,
	--  }

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
