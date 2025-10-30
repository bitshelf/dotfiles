return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"bash",
				"bitbake",
				"bp",
				"c",
				"cpp",
				"diff",
				"gitcommit",
				"git_config",
				"git_rebase",
				"gitignore",
				"gitattributes",
				"kconfig",
				"ninja",
				"rust",
				"typescript",
				"kotlin",
				"java",
				"markdown",
				"json",
				"vimdoc",
				"vim",
				"lua",
				"devicetree",
				"blueprint",
				"gn",
				"query",
				"kdl",
				"python",
				"yaml",
			},

			-- highlight = {
			--   enable = true,
			--   disable = { "devicetree",}, -- list of language that will be disabled
			--   additional_vim_regex_highlighting = false,
			-- },

			matchup = {
				enable = true,
			},

			context_commentstring = {
				enable = true,
			},

			textobjects = {
				lsp_interop = {
					enable = true,
					border = 'none',
					floating_preview_opts = {},
					peek_definition_code = {
						["gsf"] = "@function.outer",
						["gsc"] = "@class.outer",
					},
				},
			},
		},
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = "VeryLazy",
		opts = {
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				-- LazyVim extention to create buffer-local keymaps
				keys = {
					goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
					goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
					goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
					goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
				},
			},
		},
		config = function(_, opts)
			local TS = require("nvim-treesitter-textobjects")
			if not TS.setup then
				LazyVim.error("Please use `:Lazy` and update `nvim-treesitter`")
				return
			end
			TS.setup(opts)

			local function attach(buf)
				local ft = vim.bo[buf].filetype
				if not (vim.tbl_get(opts, "move", "enable") and LazyVim.treesitter.have(ft, "textobjects")) then
					return
				end
				---@type table<string, table<string, string>>
				local moves = vim.tbl_get(opts, "move", "keys") or {}

				for method, keymaps in pairs(moves) do
					for key, query in pairs(keymaps) do
						local desc = query:gsub("@", ""):gsub("%..*", "")
						desc = desc:sub(1, 1):upper() .. desc:sub(2)
						desc = (key:sub(1, 1) == "[" and "Prev " or "Next ") .. desc
						desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and " End" or " Start")
						if not (vim.wo.diff and key:find("[cC]")) then
							vim.keymap.set({ "n", "x", "o" }, key, function()
								require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
							end, {
								buffer = buf,
								desc = desc,
								silent = true,
							})
						end
					end
				end
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("lazyvim_treesitter_textobjects", { clear = true }),
				callback = function(ev)
					attach(ev.buf)
				end,
			})
			vim.tbl_map(attach, vim.api.nvim_list_bufs())
		end,
	}
}
