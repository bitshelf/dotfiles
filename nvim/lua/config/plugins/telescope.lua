local m = { noremap = true, nowait = true }
local M = {}

M.config = {
	{
		"nvim-telescope/telescope.nvim",
		-- tag = '0.1.1',
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"LukasPietzschmann/telescope-tabs",
				config = function()
					local tstabs = require('telescope-tabs')
					tstabs.setup({
					})
					vim.keymap.set('n', '<c-t>', tstabs.list_tabs, {})
				end
			},
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		  	"nvim-telescope/telescope-ui-select.nvim",
			'stevearc/dressing.nvim',
		},
		config = function()

			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<c-p>', builtin.find_files, m)
			-- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
			-- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
			vim.keymap.set('n', '<leader>rs', builtin.resume, m)
			vim.keymap.set('n', '<c-w>', builtin.buffers, m)
			vim.keymap.set('n', '<c-h>', builtin.oldfiles, m)
			vim.keymap.set('n', '<c-_>', builtin.current_buffer_fuzzy_find, m)
			vim.keymap.set('n', 'z=', builtin.spell_suggest, m)

			vim.keymap.set('n', '<leader>d', function()
				builtin.diagnostics({
					severity_sort = true,
				})
			end, m)
			-- vim.keymap.set('n', 'gd', builtin.lsp_definitions, m)
			-- vim.keymap.set('n', '<c-t>', builtin.lsp_document_symbols, {})
			vim.keymap.set('n', 'gi', builtin.git_status, m)
			-- vim.keymap.set("n", ":", builtin.commands, m)

			local trouble = require("trouble.providers.telescope")

			local ts = require('telescope')
			local actions = require('telescope.actions')
			M.ts = ts
			ts.setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--fixed-strings",
						"--smart-case",
						"--trim",
					},
					layout_config = {
						width = 0.9,
						height = 0.9,
					},
					mappings = {
						i = {
							["<C-h>"] = "which_key",
							["<C-u>"] = "move_selection_previous",
							["<C-e>"] = "move_selection_next",
							["<C-l>"] = "preview_scrolling_up",
							["<C-y>"] = "preview_scrolling_down",
							["<esc>"] = "close",
							["<C-n>"] = require('telescope.actions').cycle_history_next,
							["<C-p>"] = require('telescope.actions').cycle_history_prev,
						}
					},
					color_devicons = true,
					prompt_prefix = "🔍 ",
					selection_caret = " ",
					path_display = { "truncate" },
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				},
				pickers = {
					buffers = {
						show_all_buffers = true,
						sort_lastused = true,
						mappings = {
							i = {
								["<c-d>"] = actions.delete_buffer,
							},
						}
					},
					find_files = {
					  theme = "dropdown",
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					command_palette = command_palette,
				}
			})
			require('dressing').setup({
				select = {
					get_config = function(opts)
						if opts.kind == 'codeaction' then
							return {
								backend = 'telescope',
								telescope = require('telescope.themes').get_cursor()
							}
						end
					end
				}
			})

			ts.load_extension("yank_history")
			ts.load_extension('dap')
			ts.load_extension('telescope-tabs')
			ts.load_extension('fzf')
			-- ts.load_extension("commander")
		end
	},
	-- {
	-- 	"FeiyouG/commander.nvim",
	-- 	dependencies = "nvim-telescope/telescope.nvim",
	-- 	config = function()
	-- 		local commander = require("commander")
	-- 		vim.keymap.set('n', '<c-q>', ":Telescope commander<CR>", m)
	-- 		commander.add({
	-- 			{
	-- 				desc = "Git diff",
	-- 				cmd = "<CMD>Telescope git_status<CR>",
	-- 			},
	-- 		})
	-- 	end
	-- }
}

return M
