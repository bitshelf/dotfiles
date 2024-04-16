return {
  {
	"andymass/vim-matchup",
	event = "LazyFile",
	setup = function()
	  vim.g.matchup_matchparen_offscreen = { method = "popup" }
	end,
  },

  {
	"amrbashir/nvim-docs-view",
	event = "LazyFile",

	lazy = true,
	cmd = "DocsViewToggle",
	opts = {
	  position = "right",
	  width = 60
	}
  }
}
