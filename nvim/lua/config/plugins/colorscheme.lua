return {
--	"folke/tokyonight.nvim",
--	lazy = false,
--	priority = 1000,
--	opts = {},
--	 config = function()
--	--	vim.cmd([[colorscheme tokyonight-night]])
-- 		vim.cmd([[colorscheme tokyonight-storm]])
--	 end,
	"theniceboy/nvim-deus",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd([[colorscheme deus]])
	end,
}
