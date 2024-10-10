return {
  {
    "ldelossa/litee-calltree.nvim",
	-- ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
	keys = { { "<A-H>", "<cmd>lua vim.lsp.buf.incoming_calls()<cr>",  desc = "calltree" } },
	-- event = "LazyFile",
	dependencies = {
	  "ldelossa/litee.nvim",
		opts = {
			notify = { enabled = false },

			tree = {
				icon_set = "codicons"
			},

			panel = {
				orientation = "right",
				panel_size = 60,
			},
		},
		config = function(_, opts) require('litee.lib').setup(opts) end
	},

    config = function()
	  -- vim.keymap.set("n", "<A-H>", "<cmd>lua vim.lsp.buf.incoming_calls()<cr>", { desc = "calltree", noremap = true, silent = true})
      require("litee.calltree").setup({
        -- When retrieving Call Hierarchy items some language servers will respond with
        -- different symbol names then when a document symbol or workspace symbol request
        -- is made.
        --
        -- To unify the experience `litee-calltree.nvim` can collect symbol details for
        -- each Call Hierarhcy item, providing a more accurate display of symbol details
        -- in the Calltree UI window.
        --
        -- This takes a little longer, but is also async, and will not block Neovim.
        resolve_symbols = true,
        -- the jump_mode used for jumping from
        -- calltree node to source code line.
        -- "invoking" will use the last window that invoked the calltree (feels natural)
        -- "neighbor" will use the closest neighbor opposite to the panel orientation
        -- (if panel is left, uses window to the right.)
        jump_mode = "invoking",
        -- enables hiding the cursor inside the Calltree UI.
        hide_cursor = true,
        -- Maps arrow keys to resizing the Calltree UI within the `litee.nvim` Panel.
        map_resize_keys = true,
        -- Disables all highlighting.
        no_hls = false,
        -- Determines if initial creation of a calltree opens in the
        -- Panel or in a Popout window. Options are "panel" or "popout"
        on_open = "panel",
        -- If true, disable all keymaps
        disable_keymaps = false,
        -- The default keymaps. Users can provide overrides
        -- to these mappings via the setup function.
        keymaps = {
          expand = "zo",
          collapse = "zc",
          collapse_all = "zM",
          jump = "<CR>",
          jump_split = "s",
          jump_vsplit = "v",
          jump_tab = "t",
          hover = "i",
          details = "d",
          close = "X",
          close_panel_pop_out = "<Esc>",
          help = "?",
          hide = "H",
          switch = "S",
          focus = "f"
        },
      })
    end
  }
}
