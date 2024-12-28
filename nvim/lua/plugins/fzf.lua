return {
  "ibhagwan/fzf-lua",
  opts = function(_, opts)
	local config = require("fzf-lua.config")
    local actions = require("fzf-lua.actions")

    return {
		"default-title",
		fzf_colors = true,
		fzf_opts = {
			-- ['--ansi'] = true,
			["--no-scrollbar"] = true,
		},
		defaults = {
			file_icons		= false,
			git_icons		= false,
			color_icons		= false,
			formatter		= "path.dirname_first",
		},
		previewers = {
			builtin = {
				extensions = {
					["png"] = img_previewer,
					["jpg"] = img_previewer,
					["jpeg"] = img_previewer,
					["gif"] = img_previewer,
					["webp"] = img_previewer,
				},
				ueberzug_scaler = "fit_contain",
			},
		},

		-- Custom LazyVim option to configure vim.ui.select
		ui_select = function(fzf_opts, items)
			return vim.tbl_deep_extend("force", fzf_opts, {
				prompt = " ",
				winopts = {
					title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
					title_pos = "center",
				},
			}, 

			fzf_opts.kind == "codeaction" and {
				winopts = {
					layout = "vertical",
					-- height is number of items minus 15 lines for the preview, with a max of 80% screen height
					height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
					width = 0.5,
					preview = not vim.tbl_isempty(LazyVim.lsp.get_clients({ bufnr = 0, name = "vtsls" })) and {
						layout = "vertical",
						vertical = "down:15,border-top",
						hidden = "hidden",
					} or {
						layout = "vertical",
						vertical = "down:15,border-top",
					},
				},
			} or {
				winopts = {
					width = 0.5,
					-- height is number of items, with a max of 80% screen height
					height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
				},
			})
		end,

		winopts = {
			width = 0.95,
			height = 0.9,
			row = 0.5,
			col = 0.5,
			preview = {
				-- default = 'bat_native',
				scrollchars = { "┃", "" },
			},
		},

		git = {
			files = {
				cwd_header = true
			},
			status = {
				preview_pager = false,
				no_header  = true,
			},
		},

	    files = {
			cwd_prompt = false,
			no_header  = true,
			-- no_header_i     = true,
			actions = {
				["alt-i"] = { actions.toggle_ignore },
				["alt-h"] = { actions.toggle_hidden },
			},
		},

		grep = {
			rg_glob         = true,
			glob_flag       = "--iglob",
			glob_separator  = "%s%-%-",
			prompt          = "❯ ",
			no_header       = true,

			actions = {
				["alt-i"] = { actions.toggle_ignore },
				["alt-h"] = { actions.toggle_hidden },
			},
		},

	    lsp = {
			symbols = {
				symbol_hl = function(s)
					return "TroubleIcon" .. s
				end,
				symbol_fmt = function(s)
					return s:lower() .. "\t"
				end,
				child_prefix = false,
			},
			code_actions = {
				previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
			},
		},
    }
  end,

  keys = {
  --   { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
  --   { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
  --   {
  --     "<leader>,",
  --     "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
  --     desc = "Switch Buffer",
  --   },
    { "<leader>/", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
  --   { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
  --   { "<leader><space>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
  --   -- find
  --   { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
  --   { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
  --   { "<leader>ff", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
  --   { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
  --   { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
  --   { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
  --   { "<leader>fR", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
  --   -- git
  --   { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
  --   { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Status" },
  --   -- search
  --   { '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
  --   { "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
  --   { "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
  --   { "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
  --   { "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
  --   { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
  --   { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
  --   { "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
  --   { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
  --   { "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
  --   { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
  --   { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
  --   { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
  --   { "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
  --   { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
  --   { "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
  --   { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
  --   { "<leader>sw", LazyVim.pick("grep_cword"), desc = "Word (Root Dir)" },
  --   { "<leader>sW", LazyVim.pick("grep_cword", { root = false }), desc = "Word (cwd)" },
  --   { "<leader>sw", LazyVim.pick("grep_visual"), mode = "v", desc = "Selection (Root Dir)" },
  --   { "<leader>sW", LazyVim.pick("grep_visual", { root = false }), mode = "v", desc = "Selection (cwd)" },
  --   { "<leader>uC", LazyVim.pick("colorschemes"), desc = "Colorscheme with Preview" },
  --   {
  --     "<leader>ss",
  --     function()
  --       require("fzf-lua").lsp_document_symbols({
  --         regex_filter = symbols_filter,
  --       })
  --     end,
  --     desc = "Goto Symbol",
  --   },
  --   {
  --     "<leader>sS",
  --     function()
  --       require("fzf-lua").lsp_live_workspace_symbols({
  --         regex_filter = symbols_filter,
  --       })
  --     end,
  --     desc = "Goto Symbol (Workspace)",
  --   },
  },
}
