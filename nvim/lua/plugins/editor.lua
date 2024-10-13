return {
	{
	  "ntpeters/vim-better-whitespace",
	  event = "BufLeave",

	  init = function()
		vim.g.better_whitespace_enabled = 0
	  end,
	},

	{
	  "echasnovski/mini.indentscope",
	  event = "LazyFile",
	  version = '*',
	  -- require('mini.indentscope').setup()
	  opts = {
		-- symbol = "▏",
		symbol = "│",
		options = { try_as_border = true, },
		mappings = {
		  -- Textobjects
		  object_scope = 'ii',
		  object_scope_with_border = 'ai',

		  -- Motions (jump to respective border line; if not present - body line)
		  goto_top = '[i',
		  goto_bottom = ']i',
		},
	  },
	  init = function()
		vim.api.nvim_create_autocmd("FileType", {
		  pattern = {
			"help",
			"alpha",
			"dashboard",
			"neo-tree",
			"Trouble",
			"trouble",
			"lazy",
			"mason",
			"notify",
			"toggleterm",
			"lazyterm",
		  },
		  callback = function()
			vim.b.miniindentscope_disable = true
		  end,
		})
	  end,
	},
	-- {
	-- 	"NvChad/nvim-colorizer.lua",
	-- 	enabled = false,
	-- 	opts = {
	-- 		filetypes = { "*" },
	-- 		user_default_options = {
	-- 			RGB = true,       -- #RGB hex codes
	-- 			RRGGBB = true,    -- #RRGGBB hex codes
	-- 			names = true,     -- "Name" codes like Blue or blue
	-- 			RRGGBBAA = false, -- #RRGGBBAA hex codes
	-- 			AARRGGBB = true,  -- 0xAARRGGBB hex codes
	-- 			rgb_fn = false,   -- CSS rgb() and rgba() functions
	-- 			hsl_fn = false,   -- CSS hsl() and hsla() functions
	-- 			css = false,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
	-- 			css_fn = false,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
	-- 			-- Available modes for `mode`: foreground, background,  virtualtext
	-- 			mode = "virtualtext", -- Set the display mode.
	-- 			-- Available methods are false / true / "normal" / "lsp" / "both"
	-- 			-- True is same as normal
	-- 			tailwind = true,
	-- 			sass = { enable = false },
	-- 			virtualtext = "■",
	-- 		},
	-- 		-- all the sub-options of filetypes apply to buftypes
	-- 		buftypes = {},
	-- 	}
	-- },

	{
    "nvimdev/dashboard-nvim",
	-- enabled = false,
    opts = function()
      local logo = [[
		   ██╗      █████╗ ███████╗██╗   ██╗
		   ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝
		   ██║     ███████║  ███╔╝  ╚████╔╝ 
		   ██║     ██╔══██║ ███╔╝    ╚██╔╝  
		   ███████╗██║  ██║███████╗   ██║   
		   ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝   
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = "Telescope find_files",                                     desc = " Find file",       icon = " ", key = "f" },
            { action = "ene | startinsert",                                        desc = " New file",        icon = " ", key = "n" },
            { action = "Telescope oldfiles",                                       desc = " Recent files",    icon = " ", key = "r" },
            { action = "Telescope live_grep",                                      desc = " Find text",       icon = " ", key = "g" },
            { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = " ", key = "s" },
            { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
            { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },
	-- {
	-- 	"fedepujol/move.nvim",
	-- 	enabled = false,
	-- 	config = function()
	-- 		local opts = { noremap = true, silent = true }
	-- 		-- Normal-mode commands
	-- 		vim.keymap.set('n', '<a-y>', ':MoveLine(1)<CR>', opts)
	-- 		vim.keymap.set('n', '<a-l>', ':MoveLine(-1)<CR>', opts)
	--
	-- 		-- Visual-mode commands
	-- 		vim.keymap.set('v', '<a-e>', ':MoveBlock(1)<CR>', opts)
	-- 		vim.keymap.set('v', '<a-u>', ':MoveBlock(-1)<CR>', opts)
	-- 	end
	-- },
	{
		"windwp/nvim-autopairs",
		event = "LazyFile",

		config = function()
			require("nvim-autopairs").setup({})
		end
	},
	{
		"folke/which-key.nvim",
		event = "LazyFile",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		opts = {
			plugins = {
					spelling = true,
					registers = true,
					marks = true,
			},
			icons = { rules = false, },
			triggers = {
				{ "<auto>", mode = "nisotc" },
			},
			spec = {
			  {
				mode = { "n", "v"},
				{ "g", group = "+goto" },
				{ "gs", group = "+surround" },
				{ "]",  group = "+next" },
				{ "[",  group = "+prev" },
				{ "<leader>e",  group = "+edit" },
				{ "<leader>o",  group = "+symbol" },
				{ "<leader>g",  group = "+git/goto" },
				{ "<leader>;",  group = "Telescope commands" },
			  },
			},
	},
  },

  {
	'luozhiya/fittencode.nvim',
	-- event = "LazyFile",
	event = "InsertEnter",
	config = function()
		require('fittencode').setup()
	end,
  },

  -- file explorer
	--  {
	--    "nvim-neo-tree/neo-tree.nvim",
	-- enable = false,
	--    branch = "v3.x",
	--    cmd = "Neotree",
	--    keys = {
	--      {
	--        "<leader>fe",
	--        function()
	--          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
	--        end,
	--        desc = "Explorer NeoTree (cwd)",
	--      },
	--      -- { "<leader>fe", "<leader>fe", desc = "Explorer NeoTree (cwd)", remap = true },
	--      {
	--        "<leader>ge",
	--        function()
	--          require("neo-tree.command").execute({ source = "git_status", toggle = true })
	--        end,
	--        desc = "Git explorer",
	--      },
	--      {
	--        "<leader>be",
	--        function()
	--          require("neo-tree.command").execute({ source = "buffers", toggle = true })
	--        end,
	--        desc = "Buffer explorer",
	--      },
	--    },
	--    deactivate = function()
	--      vim.cmd([[Neotree close]])
	--    end,
	--    init = function()
	--      if vim.fn.argc(-1) == 1 then
	--        local stat = vim.loop.fs_stat(vim.fn.argv(0))
	--        if stat and stat.type == "directory" then
	--          require("neo-tree")
	--        end
	--      end
	--    end,
	--    opts = {
	--      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
	--      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
	--      filesystem = {
	--        bind_to_cwd = false,
	--        follow_current_file = { enabled = true },
	--        use_libuv_file_watcher = true,
	--      },
	--      window = {
	--        mappings = {
	--          ["<space>"] = "none",
	--        },
	--      },
	--      default_component_configs = {
	--        indent = {
	--          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
	--          expander_collapsed = "",
	--          expander_expanded = "",
	--          expander_highlight = "NeoTreeExpander",
	--        },
	--      },
	--    },
	--  },
}
