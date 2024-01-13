local m = { noremap = true, nowait = true }
local is_inside_work_tree = {}
local M = {}
local G = {}

M.config = {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false,
		event = "VimEnter",
		-- event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		-- tag = '0.1.1',
  --   dependencies = {
  --     {
  --       "nvim-telescope/telescope-fzf-native.nvim",
  --       build = "make",
  --       enabled = vim.fn.executable("make") == 1,
  --       config = function()
  --         Util.on_load("telescope.nvim", function()
  --           require("telescope").load_extension("fzf")
  --         end)
  --       end,
  --     },
  --   },
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
			{
			  "nvim-telescope/telescope-fzf-native.nvim",
			  build = "make",
			  enabled = vim.fn.executable("make") == 1,
			},
			-- {
			--   "nvim-telescope/telescope-fzy-native.nvim",
			--   build = "make",
			--   event = "BufRead",
			-- },
			-- "nvim-telescope/telescope-ui-select.nvim",
			'stevearc/dressing.nvim',
		},
		config = function()

			local builtin = require('telescope.builtin')
			-- vim.keymap.set('n', '<c-p>', builtin.find_files, m)
			vim.keymap.set('n', '<c-p>', G.project_files, m)
			vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
			-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
			vim.keymap.set('n', '<leader>rs', builtin.resume, m)
			vim.keymap.set('n', '<leader>ch', builtin.command_history, m)
			vim.keymap.set('n', '<leader>fb', builtin.buffers, m)
			vim.keymap.set('n', '<c-h>', builtin.oldfiles, m)
			vim.keymap.set('n', '<c-_>', builtin.current_buffer_fuzzy_find, m)
			vim.keymap.set('n', 'z=', builtin.spell_suggest, m)

			vim.keymap.set('n', '<leader>d', function()
				builtin.diagnostics({
					severity_sort = true,
				})
			end, m)
			vim.keymap.set('n', 'gd', builtin.lsp_definitions, m)
			vim.keymap.set('n', '<c-t>', builtin.lsp_document_symbols, {})
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
				        horizontal = {
						  -- prompt_position = 'top',
						  preview_width = 0.55,
						  results_width = 0.8,
						},
						width = 0.95,
						height = 0.95,
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
					  theme = "ivy",
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

			-- ts.load_extension("yank_history")
			-- ts.load_extension('dap') -- telescope debug extensions
			ts.load_extension('telescope-tabs')
			ts.load_extension('fzf')
			-- ts.load_extension('fzy_native')
			ts.load_extension('projects')
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

return M
