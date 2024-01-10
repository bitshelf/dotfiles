local m = { noremap = true, nowait = true }
local is_inside_work_tree = {}
local M = {}
local G = {}

M.config = {
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   cmd = "Telescope",
  --   version = false, -- telescope did only one release, so use HEAD for now
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
  --   keys = {
  --     {
  --       "<leader>,",
  --       "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
  --       desc = "Switch Buffer",
  --     },
  --     { "<leader>/", Util.telescope("live_grep"), desc = "Grep (root dir)" },
  --     { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
  --     { "<leader><space>", Util.telescope("files"), desc = "Find Files (root dir)" },
  --     -- find
  --     { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
  --     { "<leader>fc", Util.telescope.config_files(), desc = "Find Config File" },
  --     { "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
  --     { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
  --     { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
  --     { "<leader>fR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
  --     -- git
  --     { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
  --     { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
  --     -- search
  --     { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
  --     { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
  --     { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
  --     { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
  --     { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
  --     { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
  --     { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
  --     { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
  --     { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
  --     { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
  --     { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
  --     { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
  --     { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
  --     { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
  --     { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
  --     { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
  --     { "<leader>sw", Util.telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
  --     { "<leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
  --     { "<leader>sw", Util.telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
  --     { "<leader>sW", Util.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
  --     { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
  --     {
  --       "<leader>ss",
  --       function()
  --         require("telescope.builtin").lsp_document_symbols({
  --           symbols = require("lazyvim.config").get_kind_filter(),
  --         })
  --       end,
  --       desc = "Goto Symbol",
  --     },
  --     {
  --       "<leader>sS",
  --       function()
  --         require("telescope.builtin").lsp_dynamic_workspace_symbols({
  --           symbols = require("lazyvim.config").get_kind_filter(),
  --         })
  --       end,
  --       desc = "Goto Symbol (Workspace)",
  --     },
  --   },
  --   opts = function()
  --     local actions = require("telescope.actions")

  --     local open_with_trouble = function(...)
  --       return require("trouble.providers.telescope").open_with_trouble(...)
  --     end
  --     local open_selected_with_trouble = function(...)
  --       return require("trouble.providers.telescope").open_selected_with_trouble(...)
  --     end
  --     local find_files_no_ignore = function()
  --       local action_state = require("telescope.actions.state")
  --       local line = action_state.get_current_line()
  --       Util.telescope("find_files", { no_ignore = true, default_text = line })()
  --     end
  --     local find_files_with_hidden = function()
  --       local action_state = require("telescope.actions.state")
  --       local line = action_state.get_current_line()
  --       Util.telescope("find_files", { hidden = true, default_text = line })()
  --     end

  --     return {
  --       defaults = {
  --         prompt_prefix = " ",
  --         selection_caret = " ",
  --         -- open files in the first window that is an actual file.
  --         -- use the current window if no other window is available.
  --         get_selection_window = function()
  --           local wins = vim.api.nvim_list_wins()
  --           table.insert(wins, 1, vim.api.nvim_get_current_win())
  --           for _, win in ipairs(wins) do
  --             local buf = vim.api.nvim_win_get_buf(win)
  --             if vim.bo[buf].buftype == "" then
  --               return win
  --             end
  --           end
  --           return 0
  --         end,
  --         mappings = {
  --           i = {
  --             ["<c-t>"] = open_with_trouble,
  --             ["<a-t>"] = open_selected_with_trouble,
  --             ["<a-i>"] = find_files_no_ignore,
  --             ["<a-h>"] = find_files_with_hidden,
  --             ["<C-Down>"] = actions.cycle_history_next,
  --             ["<C-Up>"] = actions.cycle_history_prev,
  --             ["<C-f>"] = actions.preview_scrolling_down,
  --             ["<C-b>"] = actions.preview_scrolling_up,
  --           },
  --           n = {
  --             ["q"] = actions.close,
  --           },
  --         },
  --       },
  --     }
  --   end,
  -- },
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

			ts.load_extension("yank_history")
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
