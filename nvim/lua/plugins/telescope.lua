local project_files = function()
  local builtin = require('telescope.builtin')
  local is_inside_work_tree = {}

  -- local bufnr = vim.api.nvim_get_current_buf()
  -- local file_path = vim.api.nvim_buf_get_name(bufnr)
  -- local cwd = vim.fn.fnamemodify(file_path.path, ":p:h")
  local cwd = vim.fn.getcwd()
  local opts = {
			git_command = {
			  "git",
			  "-C",
			  cwd,
			  "ls-files",
			  "--exclude-standard",
			  "--cached",
			  "--",
			  cwd,
		  },
  } -- define here if you want to define something

  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  if is_inside_work_tree[cwd] then
    builtin.git_files(opts)
  else
	builtin.find_files({
	  hidden = true,
    })
  end

end

return {
		"nvim-telescope/telescope.nvim",
		version = false, -- telescope did only one release, so use HEAD for now
		cmd = "Telescope",

		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"stevearc/dressing.nvim",
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
				}),
			},
			{
				"LukasPietzschmann/telescope-tabs",
				config = function()
					local tstabs = require('telescope-tabs')
					tstabs.setup({
					})
					vim.keymap.set('n', '<leader>t', tstabs.list_tabs, { desc = "Tabs", noremap = true, nowait = true })
				end
			},
			{
				"nvim-telescope/telescope-live-grep-args.nvim" ,
				-- This will not install any breaking changes.
				-- For major updates, this must be adjusted manually.
				version = "^1.0.0",
			},
		},

		keys = {
		  {
			"<c-p>",
			function() project_files() end,
			desc = "Find Plugin File",
		  },
		  {'<leader>ff', function() require('telescope.builtin').fd() end, desc = "find_files" },
		  { '<leader>fh', "<cmd>Telescope search_history<cr>", desc = "search_history" },
		  { '<leader>j', "<cmd>Telescope jumplist<cr>", desc = "jumplist" },
		  { '<leader>m', "<cmd>Telescope marks initial_mode=insert<cr>", desc = "all marks" },
		  { "<leader>/","<cmd>Telescope live_grep_args live_grep_args<cr>", { desc = "Ripgrep", noremap = true, nowait = true }},
		  { "<leader>sg", LazyVim.pick("live_grep" ), desc = "Grep (cwd)" },
		  { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (root dir)" },
		  { '<leader>fs',"<cmd>Telescope lsp_document_symbols<cr>", { desc = "lsp document symbols", noremap = true, nowait = true }},
		  { '<leader>;', "<cmd>Telescope commands<cr>", { desc = "telescope commands", noremap = true, nowait = true }},
		},

		opts = function()

			local actions = require('telescope.actions')
			local ts = require('telescope')

			-- ts.load_extension("fzf")
			-- ts.load_extension("noice")
			ts.load_extension('telescope-tabs')
			ts.load_extension('projects')
			ts.load_extension("live_grep_args")
			-- ts.load_extension('fzy_native')
			-- ts.load_extension('dap') -- telescope debug extensions

			local find_files_no_ignore = function()
			  local action_state = require("telescope.actions.state")
			  local line = action_state.get_current_line()
			  LazyVim.pick("find_files", { no_ignore = true, default_text = line })()
			end

			local find_files_with_hidden = function()
			  local action_state = require("telescope.actions.state")
			  local line = action_state.get_current_line()
			  LazyVim.pick("find_files", { hidden = true, default_text = line })()
			end

			return {
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
				        horizontal = {
						  -- prompt_position = 'top',
						  preview_width = 0.60,
						  results_width = 0.40,
						},
						width = 0.95,
						height = 0.95,
					},

					mappings = {
						i = {
							["<C-j>"] = actions.cycle_history_next,
							["<C-k>"] = actions.cycle_history_prev,
							["<C-n>"] = actions.move_selection_next,
							["<C-p>"] = actions.move_selection_previous,

							["<C-Down>"] = actions.cycle_history_next,
							["<C-Up>"] = actions.cycle_history_prev,

							["<C-u>"] = actions.preview_scrolling_up,
							["<C-d>"] = actions.preview_scrolling_down,
							["<C-b>"] = actions.preview_scrolling_left,
							["<C-f>"] = actions.preview_scrolling_right,

							["<C-c>"] = actions.close,

							["<Down>"] = actions.move_selection_next,
							["<Up>"] = actions.move_selection_previous,

							["<CR>"] = actions.select_default,
							["<C-x>"] = actions.select_horizontal,
							["<C-v>"] = actions.select_vertical,
							["<C-t>"] = actions.select_tab,

							["<a-i>"] = find_files_no_ignore,
							["<a-h>"] = find_files_with_hidden,

							["<PageUp>"] = actions.results_scrolling_up,
							["<PageDown>"] = actions.results_scrolling_down,
							["<M-f>"] = actions.results_scrolling_right,
							["<M-b>"] = actions.results_scrolling_left,

							["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
							["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
							["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
							["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<C-/>"] = actions.which_key,
							["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
							["<C-w>"] = { "<c-s-w>", type = "command" },

							-- disable c-j because we dont want to allow new lines #2123
							-- ["<C-j>"] = actions.nop,
							["<M-j>"] = actions.nop,
							["<M-k>"] = actions.nop,
						},

						n = { 
						  q = actions.close 
						},
					},

					color_devicons = true,
					prompt_prefix = "🔍 ",
					selection_caret = " ",
					path_display = { "truncate" },
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
					-- open files in the first window that is an actual file.
					-- use the current window if no other window is available.
					get_selection_window = function()
					  local wins = vim.api.nvim_list_wins()
					  table.insert(wins, 1, vim.api.nvim_get_current_win())
					  for _, win in ipairs(wins) do
						local buf = vim.api.nvim_win_get_buf(win)
						if vim.bo[buf].buftype == "" then
						  return win
						end
					  end
					  return 0
					end,
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
					  -- theme = "ivy",
					  cwd = vim.fn.expand('%:p:h'),
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},

			  --       fzy_native = {
					--   override_generic_sorter = false,
					--   override_file_sorter = true,
					-- },

					command_palette = command_palette
				},
		}
	  end
}

