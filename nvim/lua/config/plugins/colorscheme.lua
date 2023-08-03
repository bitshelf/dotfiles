return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,

	config = function()
	 require('tokyonight').setup({
	  -- your configuration comes here
	  -- or leave it empty to use the default settings
	  style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
	  transparent = false, -- Enable this to disable setting the background color
	  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
	  styles = {
	    -- Style to be applied to different syntax groups
	    -- Value is any valid attr-list value for `:help nvim_set_hl`
	    comments = { italic = true },
	    keywords = { italic = true },
	    functions = {},
	    variables = {},
	    -- Background styles. Can be "dark", "transparent" or "normal"
	    -- sidebars = "dark", -- style for sidebars, see below
	    -- floats = "dark", -- style for floating windows
	  },
	  hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
	  dim_inactive = false, -- dims inactive windows
	  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
	  show_end_of_line = true,

	  --- You can override specific color groups to use other groups or a hex color
	  --- function will be called with a ColorScheme table
	  ---@param colors ColorScheme
	  --on_colors = function(colors) end,

	  --- You can override specific highlights to use other groups or a hex color
	  --- function will be called with a Highlights and ColorScheme table
	  ---@param highlights Highlights
	  ---@param colors ColorScheme
	  on_highlights = function(highlights, colors) end,
	}
	)
		 vim.cmd.colorscheme('tokyonight')
		-- vim.cmd("colorscheme tokyonight")
end

	-- "theniceboy/nvim-deus",
	-- lazy = false,
	-- priority = 1000,
	-- config = function()
	-- 	vim.cmd([[colorscheme deus]])
	-- end,
}
