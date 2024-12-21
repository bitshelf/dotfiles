return {
	{
	  "ntpeters/vim-better-whitespace",
	  event = "LazyFile",

	  init = function()
		vim.g.better_whitespace_enabled = 0
	  end,
	},

	-- {
	--   "echasnovski/mini.indentscope",
	--
	--   opts = {
	-- 	-- symbol = "▏",
	-- 	symbol = "│",
	-- 	options = { try_as_border = true, },
	-- 	mappings = {
	-- 	  -- Textobjects
	-- 	  object_scope = 'ii',
	-- 	  object_scope_with_border = 'ai',
	--
	-- 	  -- Motions (jump to respective border line; if not present - body line)
	-- 	  goto_top = '[i',
	-- 	  goto_bottom = ']i',
	-- 	},
	--   },
	-- },

	-- {
	-- 	"windwp/nvim-autopairs",
	-- 	event = "LazyFile",
	--
	-- 	config = function()
	-- 		require("nvim-autopairs").setup({})
	-- 	end
	-- },
	--
	-- {
	-- 	"folke/which-key.nvim",
	-- 	init = function()
	-- 		vim.o.timeout = true
	-- 		vim.o.timeoutlen = 500
	-- 	end,
	-- 	opts = {
	-- 		plugins = {
	-- 				spelling = true,
	-- 				registers = true,
	-- 				marks = true,
	-- 		},
	-- 		icons = { rules = false, },
	-- 		triggers = {
	-- 			{ "<auto>", mode = "nisotc" },
	-- 		},
	-- 		spec = {
	-- 		  {
	-- 			mode = { "n", "v"},
	-- 			{ "g", group = "+goto" },
	-- 			{ "gs", group = "+surround" },
	-- 			{ "]",  group = "+next" },
	-- 			{ "[",  group = "+prev" },
	-- 			{ "<leader>e",  group = "+edit" },
	-- 			{ "<leader>o",  group = "+symbol" },
	-- 			{ "<leader>g",  group = "+git/goto" },
	-- 			{ "<leader>;",  group = "Telescope commands" },
	-- 		  },
	-- 		},
	-- },
 --  },
}
