vim.cmd([[
fun! s:MakePair()
	let line = getline('.')
	let len = strlen(line)
	if line[len - 1] == ";" || line[len - 1] == ","
		normal! lx$P
	else
		normal! lx$p
	endif
endfun
inoremap <c-u> <ESC>:call <SID>MakePair()<CR>
]])


return {
	{
	  "echasnovski/mini.indentscope",
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
	{
		"RRethy/vim-illuminate",
		config = function()
			require('illuminate').configure({
				providers = {
					-- 'lsp',
					'treesitter',
					'regex',
				},
				delay = 200,
			    large_file_cutoff = 2000,

			    large_file_overrides = {
					providers = { "lsp" },
				 },
			})
			vim.cmd("hi IlluminatedWordText guibg=#393E4D gui=none")
		end
	},
	{
      "nvim-pack/nvim-spectre",                                                                                                                                               build = false,
      cmd = "Spectre",
      opts = { open_cmd = "noswapfile vnew" },
      -- stylua: ignore
      keys = {
        { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
      },
    },

	{
	  "goolord/alpha-nvim",
	  event = "VimEnter",
	  enabled = false,
	  init = false,
	  opts = function()
		local dashboard = require("alpha.themes.dashboard")
		local logo = [[
			   ██╗      █████╗ ███████╗██╗   ██╗
			   ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝
			   ██║     ███████║  ███╔╝  ╚████╔╝ 
			   ██║     ██╔══██║ ███╔╝    ╚██╔╝  
			   ███████╗██║  ██║███████╗   ██║   
			   ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝   
		]]

		dashboard.section.header.val = vim.split(logo, "\n")
		-- stylua: ignore
		dashboard.section.buttons.val = {
		  dashboard.button("f", " " .. " Find file",       "<cmd> Telescope find_files <cr>"),
		  dashboard.button("n", " " .. " New file",        "<cmd> ene <BAR> startinsert <cr>"),
		  dashboard.button("r", " " .. " Recent files",    "<cmd> Telescope oldfiles <cr>"),
		  dashboard.button("g", " " .. " Find text",       "<cmd> Telescope live_grep <cr>"),
		  dashboard.button("c", " " .. " Config",          "<cmd> lua require('lazyvim.util').telescope.config_files()() <cr>"),
		  dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
		  dashboard.button("x", " " .. " Lazy Extras",     "<cmd> LazyExtras <cr>"),
		  dashboard.button("l", "󰒲 " .. " Lazy",            "<cmd> Lazy <cr>"),
		  dashboard.button("q", " " .. " Quit",            "<cmd> qa <cr>"),
		}
		for _, button in ipairs(dashboard.section.buttons.val) do
		  button.opts.hl = "AlphaButtons"
		  button.opts.hl_shortcut = "AlphaShortcut"
		end
		dashboard.section.header.opts.hl = "AlphaHeader"
		dashboard.section.buttons.opts.hl = "AlphaButtons"
		dashboard.section.footer.opts.hl = "AlphaFooter"
		dashboard.opts.layout[1].val = 8
		return dashboard
	  end,
	  config = function(_, dashboard)
		-- close Lazy and re-open when the dashboard is ready
		if vim.o.filetype == "lazy" then
		  vim.cmd.close()
		  vim.api.nvim_create_autocmd("User", {
			once = true,
			pattern = "AlphaReady",
			callback = function()
			  require("lazy").show()
			end,
		  })
		end

		require("alpha").setup(dashboard.opts)

		vim.api.nvim_create_autocmd("User", {
		  once = true,
		  pattern = "LazyVimStarted",
		  callback = function()
			local stats = require("lazy").stats()
			local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
			dashboard.section.footer.val = "⚡ Neovim loaded "
			  .. stats.loaded
			  .. "/"
			  .. stats.count
			  .. " plugins in "
			  .. ms
			  .. "ms"
			pcall(vim.cmd.AlphaRedraw)
		  end,
		})
	  end,
	},

	{
		"NvChad/nvim-colorizer.lua",
		enable = false,
		opts = {
			filetypes = { "*" },
			user_default_options = {
				RGB = true,       -- #RGB hex codes
				RRGGBB = true,    -- #RRGGBB hex codes
				names = true,     -- "Name" codes like Blue or blue
				RRGGBBAA = false, -- #RRGGBBAA hex codes
				AARRGGBB = true,  -- 0xAARRGGBB hex codes
				rgb_fn = false,   -- CSS rgb() and rgba() functions
				hsl_fn = false,   -- CSS hsl() and hsla() functions
				css = false,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = false,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
				-- Available modes for `mode`: foreground, background,  virtualtext
				mode = "virtualtext", -- Set the display mode.
				-- Available methods are false / true / "normal" / "lsp" / "both"
				-- True is same as normal
				tailwind = true,
				sass = { enable = false },
				virtualtext = "■",
			},
			-- all the sub-options of filetypes apply to buftypes
			buftypes = {},
		}
	},
  {
    "nvimdev/dashboard-nvim",
	-- enabled = false,
    event = "VimEnter",
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
	{ 'gcmt/wildfire.vim',  lazy = false, },
	{
		"fedepujol/move.nvim",
		enabled = false,
		config = function()
			local opts = { noremap = true, silent = true }
			-- Normal-mode commands
			vim.keymap.set('n', '<a-y>', ':MoveLine(1)<CR>', opts)
			vim.keymap.set('n', '<a-l>', ':MoveLine(-1)<CR>', opts)

			-- Visual-mode commands
			vim.keymap.set('v', '<a-e>', ':MoveBlock(1)<CR>', opts)
			vim.keymap.set('v', '<a-u>', ':MoveBlock(-1)<CR>', opts)
		end
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end
	},
	{
		'wfxr/minimap.vim',
		enable = false,
		build = "cargo install --locked code-minimap",
		cmd = {"Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight"},
		config = function ()
		  vim.cmd ("let g:minimap_width = 10")
		  vim.cmd ("let g:minimap_auto_start = 1")
		  vim.cmd ("let g:minimap_auto_start_win_enter = 1")
		end,
  },

  {
	"folke/which-key.nvim",
	event = "VimEnter",
	init = function()
	  vim.o.timeout = true
	  vim.o.timeoutlen = 500
	end,
	opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gs"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>o"] = { name = "+symbol" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      },
	},

    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = vim.opt.sessionoptions:get() },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
}
