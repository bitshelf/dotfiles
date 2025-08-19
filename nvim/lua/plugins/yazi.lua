return {
	{
		"mikavilpas/yazi.nvim",

		keys = {
			-- 👇 in this section, choose your own keymappings!
			{ "<leader>ey", function()
					require("yazi").yazi()
				end,
				desc = "Open the file manager",
			},
				-- Open in the current working directory
			{ "<leader>ew", function()
					require("yazi").yazi(nil, vim.fn.getcwd())
				end,
				desc = "Open the file manager in nvim's working directory" ,
			},
		},

		---@type YaziConfig
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = true,
		},
	},

	{
      "nvim-neo-tree/neo-tree.nvim",
	  enabled = false,

      opts = {
        filesystem = {
          hijack_netrw_behavior = "disabled",
        },
      },
    },
}
