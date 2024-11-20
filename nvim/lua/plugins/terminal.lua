return {
	{
		'akinsho/toggleterm.nvim',
		cmd = "ToggleTerm",
		keys = { { "<c-\\>", "<cmd>Toggleterm<cr>",  desc = "Toggleterm" } },
		-- enabled = false,
		opts = {
			open_mapping = [[<c-\>]],
			direction = 'float',
			close_on_exit = true, -- close the terminal window when the process exits
			-- Change the default shell. Can be a string or a function returning a string
			shell = vim.o.shell,
			auto_scroll = true, -- automatically scroll to the bottom on terminal output
			-- This field is only relevant if direction is set to 'float'
			float_opts = {
				-- The border key is *almost* the same as 'nvim_open_win'
				-- see :h nvim_open_win for details on borders however
				-- the 'curved' border is a custom border type
				-- not natively supported but implemented in this plugin.
				border = 'single',
				-- width = 100,
				height = 80,
			},
		},
	},
	-- {
	-- 	"folke/edgy.nvim",
	-- 	---@module 'edgy'
	-- 	---@param opts Edgy.Config
	-- 	opts = function(_, opts)
	-- 		for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
	-- 		opts[pos] = opts[pos] or {}
	-- 		table.insert(opts[pos], {
	-- 			ft = "snacks_terminal",
	-- 			size = { height = 0.4 },
	-- 			title = "%{b:snacks_terminal.id}: %{b:term_title}",
	-- 			filter = function(_buf, win)
	-- 			return vim.w[win].snacks_win
	-- 				and vim.w[win].snacks_win.position == pos
	-- 				and vim.w[win].snacks_win.relative == "editor"
	-- 				and not vim.w[win].trouble_preview
	-- 			end,
	-- 		})
	-- 		end
	-- 	end,
	-- }
}
