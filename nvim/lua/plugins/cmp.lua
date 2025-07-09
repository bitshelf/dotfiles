return {
  'saghen/blink.cmp',
  event = {'BufReadPost', 'BufNewFile' },
  dependencies = { "xzbdmw/colorful-menu.nvim", opts ={} },

  opts = {
    keymap = {
		['<CR>'] = { 'accept', 'fallback' },
		['<C-y>'] = { 'select_and_accept' },
		['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
		['<C-d>'] = { 'scroll_documentation_down', 'fallback' },

		-- super-tab
		['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
		['<C-e>'] = { 'hide', 'fallback' },

		['<Tab>'] = {
		function(cmp)
			if cmp.snippet_active() then return cmp.accept()
			else return cmp.select_and_accept() end
		end,
		'snippet_forward',
		'fallback'
		},
		['<S-Tab>'] = { 'snippet_backward', 'fallback' },

		['<Up>'] = { 'select_prev', 'fallback' },
		['<Down>'] = { 'select_next', 'fallback' },
		['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
		['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

		['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
		['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

		['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
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
