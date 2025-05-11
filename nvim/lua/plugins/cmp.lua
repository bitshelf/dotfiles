return {
  'saghen/blink.cmp',
  event = {'BufReadPost', 'BufNewFile' },
  dependencies = { "xzbdmw/colorful-menu.nvim", opts ={} },

  opts = {
    keymap = {
		preset = 'super-tab',

		['<CR>'] = { 'accept', 'fallback' },
		['<C-y>'] = { 'select_and_accept' },
		['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
		['<C-d>'] = { 'scroll_documentation_down', 'fallback' }
	},

    completion = {
		ghost_text = {
			enabled = false,
		},
		documentation = {
				auto_show = true,
		},
		menu = {
			draw = {
				columns = { { 'kind_icon' }, { 'label', gap = 1 } },
				components = {
					label = {
						text = function(ctx)
							return require('colorful-menu').blink_components_text(ctx)
						end,
						highlight = function(ctx)
							return require('colorful-menu').blink_components_highlight(ctx)
						end,
					},
				},
			},
		},
    },
	signature = {
		enabled = true,
	},
	cmdline = {
		completion = {
			menu = {
				auto_show = true,
			},
		},
    },
  },
}
