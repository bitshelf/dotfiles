return {
  {
	'gelguy/wilder.nvim',
	enabled = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local wilder = require('wilder')
		wilder.setup {
			modes = { ':' },
			next_key = '<Tab>',
			previous_key = '<S-Tab>',
		}
		wilder.set_option('renderer', wilder.popupmenu_renderer(
			wilder.popupmenu_palette_theme({
				highlights = {
					border = 'Normal', -- highlight to use for the border
				},
				left = { ' ', wilder.popupmenu_devicons() },
				right = { ' ', wilder.popupmenu_scrollbar() },
				border = 'rounded',
				max_height = '75%',  -- max height of the palette
				min_height = 0,      -- set to the same as 'max_height' for a fixed height window
				prompt_position = 'top', -- 'top' or 'bottom' to set the location of the prompt
				reverse = 0,         -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
			})
		))
		wilder.set_option('pipeline', {
			wilder.branch(
				wilder.cmdline_pipeline({
					language = 'vim',
					fuzzy = 1,
				}), wilder.search_pipeline()
			),
		})
	end
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",

	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		"rcarriga/nvim-notify",
    },

    opts = {
      -- lsp = {
      --   override = {
      --     ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      --     ["vim.lsp.util.stylize_markdown"] = true,
      --     ["cmp.entry.get_documentation"] = true,
      --   },
      -- },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
    },
    -- stylua: ignore
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
    },
  },
}
