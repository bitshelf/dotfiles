return {
  {
	"andymass/vim-matchup",
	-- event = "VimEnter",
	setup = function()
	  vim.g.matchup_matchparen_offscreen = { method = "popup" }
	end,
  },

  {
	"amrbashir/nvim-docs-view",
	event = "VimEnter",

	lazy = true,
	cmd = "DocsViewToggle",
	opts = {
	  position = "right",
	  width = 60
	}
  }
}
