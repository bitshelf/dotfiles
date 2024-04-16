return {
	{
		"gbprod/yanky.nvim",
		event = "LazyFile",
		-- enabled = false,
		-- dependencies = {
		-- 	"kkharji/sqlite.lua",
		-- },
		keys = {
			{ "<leader>p", function() require("telescope").extensions.yank_history.yank_history({ }) end, desc = "Open Yank History" },
			{ "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
			{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
			{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
			{ "gp", "<Plug>(YankyCycleForward)", mode = { "n", "x" }, desc = "Put yanked text before YankyCycleForward" },
			{ "gP", "<Plug>(YankyCycleForward)", mode = { "n", "x" }, desc = "Put yanked text after YankyCycleBackward" },
			{ "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
			{ "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
			{ ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
			{ "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
			{ ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
			{ "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
			{ "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
			{ "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
		},
		config = function()
			-- vim.keymap.set("n", "<leader>y", ":Telescope yank_history<CR>")
			-- vim.keymap.set("n", "<c-u>", "<Plug>(YankyCycleForward)")
			-- vim.keymap.set("n", "<c-e>", "<Plug>(YankyCycleBackward)")
			-- vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
			-- vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
			-- vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
			-- vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

			local utils = require("yanky.utils")
			local mapping = require("yanky.telescope.mapping")

			local ts = require('telescope')
			ts.load_extension("yank_history")

			require('yanky').setup({
				ring = {
					history_length = 2000,
					storage = "shada",
					ignore_registers = { "_" },
					update_register_on_cycle = false,
					sync_with_numbered_registers = true,
					cancel_event = "update",
				},

				picker = {
					select = {
						action = nil, -- nil to use default put action
					},
					telescope = {
						use_default_mappings = false, -- if default mappings should be used
						-- mappings = nil,        -- nil to use default mappings or no mappings (see `use_default_mappings`)
						mappings = {
						  default = mapping.put("p"),
						  i = {
							-- ["<c-g>"] = mapping.put("p"),
							-- ["<c-k>"] = mapping.put("P"),
							["<c-x>"] = mapping.delete(),
							["<c-r>"] = mapping.set_register(utils.get_default_register()),
						  },
						  n = {
							p = mapping.put("p"),
							P = mapping.put("P"),
							d = mapping.delete(),
							r = mapping.set_register(utils.get_default_register())
						  },
						}
					},
				},

				system_clipboard = {
					sync_with_ring = true,
				},

				highlight = {
					on_put = true,
					on_yank = true,
					timer = 300,
				},

				preserve_cursor_position = {
					enabled = true,
				},
			})
		end
	},
}
