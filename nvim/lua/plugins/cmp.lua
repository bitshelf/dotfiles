return {
  'saghen/blink.cmp',

  opts = {
    keymap = { 
		preset = 'super-tab',

		['<CR>'] = { 'accept', 'fallback' },
		['<C-y>'] = { 'select_and_accept' },
	},
  },
}
