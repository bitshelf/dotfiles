return {
  'akinsho/toggleterm.nvim', 
  event = "LazyFile",
  cmd = "ToggleTerm",
  -- enabled = false,
  opts = {
	  open_mapping = [[<c-\>]],
	  direction = 'float',
	  close_on_exit = true, -- close the terminal window when the process exits
	   -- Change the default shell. Can be a string or a function returning a string
	  shell = vim.o.shell,
	  auto_scroll = true, -- automatically scroll to the bottom on terminal output
	  -- This field is only relevant if direction is set to 'float'
	  float_opts = {
		-- The border key is *almost* the same as 'nvim_open_win'
		-- see :h nvim_open_win for details on borders however
		-- the 'curved' border is a custom border type
		-- not natively supported but implemented in this plugin.
		border = 'single',
		-- width = 100,
		height = 80,
	  },
  },
}
