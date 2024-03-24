local m = { noremap = true, nowait = true }
local is_inside_work_tree = {}
local G = {}
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

G.project_files = function()
  local builtin = require('telescope.builtin')

--   local bufnr = vim.api.nvim_get_current_buf()
--   local file_path = vim.api.nvim_buf_get_name(bufnr)
--   local cwd = vim.fn.fnamemodify(file_path.path, ":p:h")
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
	-- builtin.find_files({
	--   hidden = true,
	--   find_command = { "git", "ls-files","--", cwd,},
 --    })
    builtin.git_files(opts)
  else
    builtin.find_files(opts)
  end

end

return {
  {
		"nvim-telescope/telescope.nvim",
		version = false, -- telescope did only one release, so use HEAD for now
	    cmd = "Telescope",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
			{
				"LukasPietzschmann/telescope-tabs",
				config = function()
					local tstabs = require('telescope-tabs')
					tstabs.setup({
					})
					vim.keymap.set('n', '<leader>t', tstabs.list_tabs, {})
				end
			},
		},

		keys = {
		  {
			"<c-p>",
			function() G.project_files() end,
			desc = "Find Plugin File",
		  },
		  { '<leader>ff', function() builtin.find_files() end, desc = "find_files" },
		  { '<c-t>', function() builtin.jumplist() end, desc = "jumplist" },
		  { "<leader>/", LazyVim.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
		  { "<leader>sg", LazyVim.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
		  { "<leader>sG", LazyVim.telescope("live_grep"), desc = "Grep (root dir)" },
		  -- { '<leader>fg', function() builtin.live_grep() end, desc = "live_grep" },
		  -- { '<leader>fh', function() builtin.oldfiles() end, desc = "oldfiles" },
		  -- { '<leader>ch', function() builtin.command_history() end , desc = "command_history" },
		  -- { '<leader>fb', function() builtin.buffers() end, desc = "buffers" },
		  { '<leader>fs',function() builtin.lsp_document_symbols() end, { desc = "lsp document symbols", noremap = true, nowait = true }},
		  -- { '<leader>gs',function() builtin.git_status() end, { desc = "telescope git status", noremap = true, nowait = true }},
		  { '<leader>;', function() builtin.commands() end, { desc = "telescope commands", noremap = true, nowait = true }},
		},

		opts = {
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
						  preview_width = 0.55,
						  results_width = 0.8,
						},
						width = 0.95,
						height = 0.95,
					},
					mappings = {
						i = {
							["<esc>"] = "close",
							["<C-n>"] = actions.move_selection_next,
							["<C-p>"] = actions.move_selection_previous,

							["<C-c>"] = actions.close,

							["<Down>"] = actions.move_selection_next,
							["<Up>"] = actions.move_selection_previous,

							["<CR>"] = actions.select_default,
							["<C-x>"] = actions.select_horizontal,
							["<C-v>"] = actions.select_vertical,
							["<C-t>"] = actions.select_tab,

							["<C-u>"] = actions.preview_scrolling_up,
							["<C-d>"] = actions.preview_scrolling_down,
							["<C-f>"] = actions.preview_scrolling_left,
							["<C-k>"] = actions.preview_scrolling_right,

							["<PageUp>"] = actions.results_scrolling_up,
							["<PageDown>"] = actions.results_scrolling_down,
							["<M-f>"] = actions.results_scrolling_left,
							["<M-k>"] = actions.results_scrolling_right,

							["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
							["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
							["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
							["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<C-l>"] = actions.complete_tag,
							["<C-/>"] = actions.which_key,
							["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
							["<C-w>"] = { "<c-s-w>", type = "command" },

							-- disable c-j because we dont want to allow new lines #2123
							["<C-j>"] = actions.nop,
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
					 --  mappings = {
						-- n = {
						--   ["cd"] = function(prompt_bufnr)
						-- 	local selection = require("telescope.actions.state").get_selected_entry()
						-- 	local dir = vim.fn.fnamemodify(selection.path, ":p:h")
						-- 	require("telescope.actions").close(prompt_bufnr)
						-- 	-- Depending on what you want put `cd`, `lcd`, `tcd`
						-- 	vim.cmd(string.format("silent lcd %s", dir))
						--   end
						-- }
					 --  },
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

					command_palette = command_palette,
				}
		},

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

		config = function()
		  local ts = require('telescope')
		  ts.load_extension("fzf")
		  ts.load_extension('telescope-tabs')
		  ts.load_extension('projects')
		  ts.load_extension("yank_history")
		  -- ts.load_extension('fzy_native')
		  -- ts.load_extension('dap') -- telescope debug extensions
		  -- ts.load_extension("commander")
		end,
	},
}

