return {
	"Pocco81/auto-save.nvim",
	-- event = "VeryLazy",
	config = function()
		 require("auto-save").setup {
		    execution_message = {
			  message = function() -- message to print on save
				  return (" ")
			  end,
			},
			conditions = {
				exists = true,
				filename_is_not = { "plugins.lua" },
				filetype_is_not = {},
				modifiable = true
			},
			write_all_buffers = false,
			on_off_commands = true,
			clean_command_line_interval = 0,
			debounce_delay = 135
		 }
	end,
}
