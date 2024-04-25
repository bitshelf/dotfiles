return {
	  {
		"hedyhli/outline.nvim",
		lazy = true,
		-- event = "VimEnter",
		cmd = { "Outline", "OutlineOpen" },
		keys = { -- Example mapping to toggle outline
		  -- { "<leader>oo", "<cmd>Outline<CR>", desc = "Toggle outline" },
		  { "<leader>cs", "<cmd>Outline<cr>", desc = "Symbols Outline" },
		},
		opts = {
		  preview_window = {
			auto_preview = false,
		  },

		  keymaps = { 
			show_help = '?',
			close = {'<Esc>', 'q'},
			-- Jump to symbol under cursor.
			-- It can auto close the outline window when triggered, see
			-- 'auto_close' option above.
			goto_location = '<Cr>',
			-- Jump to symbol under cursor but keep focus on outline window.
			peek_location = 'o',
			-- Visit location in code and close outline immediately
			goto_and_close = '<S-Cr>',
			-- Change cursor position of outline window to match current location in code.
			-- 'Opposite' of goto/peek_location.
			restore_location = '<C-g>',
			-- Open LSP/provider-dependent symbol hover information
			hover_symbol = '<C-space>',
			-- Preview location code of the symbol under cursor
			toggle_preview = 'K',
			rename_symbol = 'r',
			code_actions = 'a',
			-- These fold actions are collapsing tree nodes, not code folding
			fold = 'h',
			unfold = 'l',
			fold_toggle = '<Tab>',
			-- Toggle folds for all nodes.
			-- If at least one node is folded, this action will fold all nodes.
			-- If all nodes are folded, this action will unfold all nodes.
			fold_toggle_all = '<S-Tab>',
			fold_all = 'W',
			unfold_all = 'E',
			fold_reset = 'R',
			-- Move down/up by one line and peek_location immediately.
			-- You can also use outline_window.auto_jump=true to do this for any
			-- j/k/<down>/<up>.
			down_and_jump = '<C-j>',
			up_and_jump = '<C-k>',
		  }
		},
	  },

	  {
		  "neovim/nvim-lspconfig",
		  -- event = "VimEnter",
		  cmd = { "Navbuddy",},
		  dependencies = {
			  {
				  "SmiteshP/nvim-navbuddy",
				  dependencies = {
					  "SmiteshP/nvim-navic",
					  "MunifTanjim/nui.nvim"
				  },
				  opts = {
					lsp = { auto_attach = true },

				    window = {
						border = "single",  -- "rounded", "double", "solid", "none"
											-- or an array with eight chars building up the border in a clockwise fashion
											-- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
						size = "90%",       -- Or table format example: { height = "40%", width = "100%"}
						position = "50%",   -- Or table format example: { row = "100%", col = "0%"}
						scrolloff = nil,    -- scrolloff value within navbuddy window
						sections = {
							left = {
								size = "20%",
								border = nil, -- You can set border style for each section individually as well.
							},
							mid = {
								size = "40%",
								border = nil,
							},
							right = {
								-- No size option for right most section. It fills to
								-- remaining area.
								border = nil,
								preview = "leaf",  -- Right section can show previews too.
												   -- Options: "leaf", "always" or "never"
							}
						},
					},
				  }
			  }
		  },
		  -- your lsp config or other stuff
	  }

	-- {
	-- 'stevearc/aerial.nvim',
	-- event = "VimEnter",
	-- enabled = false,
	-- opts = {},
	-- -- Optional dependencies
	-- dependencies = {
	--    "nvim-treesitter/nvim-treesitter",
	--    "nvim-tree/nvim-web-devicons"
	-- },
	-- vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>"),
 --  }

}
