return {
  {
	"andymass/vim-matchup",
	event = "LazyFile",
	enabled = false,
	setup = function()
	  vim.g.matchup_matchparen_offscreen = { method = "popup" }
	end,
  },

  {
	"amrbashir/nvim-docs-view",

	cmd = "DocsViewToggle",
	opts = {
	  position = "right",
	  width = 60
	}
  }
}
