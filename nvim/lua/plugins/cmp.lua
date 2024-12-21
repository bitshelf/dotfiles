return {
  'saghen/blink.cmp',
  event = "LazyFile",
  -- optional: provides snippets for the snippet source
  dependencies = 'rafamadriz/friendly-snippets',

  opts = {
    keymap = { 
		preset = 'super-tab',

		['<CR>'] = { 'accept', 'fallback' },
		['<C-y>'] = { 'select_and_accept' },
	},
  },
}
