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
	{
		"folke/which-key.nvim",
		event = "LazyFile",
		opts = {
			triggers = {
				{ "<auto>", mode = "nisotc" },
			},
		},
	},
}
