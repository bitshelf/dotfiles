return {
	  "celediel/poiekolon.nvim",
	  event = "VeryLazy",

	  config = function()
		require("poiekolon").setup({
			default_mode = "toggle",
			maps = {
				i = { -- the mode desired, same mode as vim's map command, i.e. n = normal, v = visual/select, i = insert
					  {
						  key = "<C-l>", -- key to be mapped
						  char = ";", -- char to be used
						  func = "add_char", -- function to be used
					  },
				},
			  },
	  })
	  end
}

