return {
	{
	  "folke/flash.nvim",
	  event = "VimEnter",
	  ---@type Flash.Config
	  opts = {
		  label = {
				uppercase = false,
				exclude = "",
				current = false,
				-- show the label after the match
				after = true, ---@type boolean|number[]
				-- show the label before the match
				before = false, ---@type boolean|number[]
				-- position of the label extmark
				style = "inline", ---@type "eol" | "overlay" | "right_align" | "inline"
				-- flash tries to re-use labels that were already assigned to a position,
				-- when typing more characters. By default only lower-case labels are re-used.
				reuse = "all", ---@type "lowercase" | "all"
				-- for the current window, label targets closer to the cursor first
				distance = true,
				-- minimum pattern length to show labels
				-- Ignored for custom labelers.
				min_pattern_length = 0,
				-- Enable this to use rainbow colors to highlight labels
				-- Can be useful for visualizing Treesitter ranges.
				rainbow = {
					enabled = true,
					-- number between 1 and 9
					shade = 8,
				},
			},
	  },
	  -- stylua: ignore
	  keys = {
	    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
	    { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
	    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
	    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
	    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		{ "K", mode = { "n", "o", "x" }, function() require("flash").jump({ search = { mode = "search", max_length = 0 }, label = { after = { 0, 0 } }, pattern = "^"}) end, desc = "goto line" },
		{ "tt",mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter",},
	  },
}
}
