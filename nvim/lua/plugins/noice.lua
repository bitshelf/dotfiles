return {
  {
    "folke/noice.nvim",
	branch = "main",

    opts = {
      lsp = {
		progress = {
			enabled = true,
		},

	    signature = {
		  auto_open = { enable = false },
		},
      },

	  messages = {
		  -- NOTE: If you enable messages, then the cmdline is enabled automatically.
		  -- This is a current Neovim limitation.
		  enabled = true, -- enables the Noice messages UI
		  view = "notify", -- default view for messages
		  view_error = "notify", -- view for errors
		  view_warn = "notify", -- view for warnings
		  view_history = "messages", -- view for :messages
		  view_search = "virtualtext" -- view for search count messages. Set to `false` to disable
	  },

      routes = {
		{
		  view = "popup",
		  filter = {
			any = {
			  { cmdline = "^:reg" },
			  { cmdline = "^:dis" },
			  { cmdline = "^:ls" },
			  { cmdline = "^:marks" },
			  { cmdline = "^:hi" },
		 }},
		},

        {
          filter = {
			-- event = "msg_show", -- look for event: hi-messages
			-- kind = "",
            any = {
				{ find = "%d+L, %d+B" },
				{ find = "; after #%d+" },
				{ find = "; before #%d+" },
				{ find = "%d lines yanked" },
				{ find = "clipboard:" },
				{ find = "Ignoring invalid" },
				{ find = "completion" },
				{ find = "UltiSnips" },
				{ find = "%d lines <ed %d time[s]?" },
				{ find = "%d lines >ed %d time[s]?" },
				{ find = "{ %d }" },
				{ find = "semantic_tokens" },
				{ event = "msg_show", find = "fewer lines" },
				{ event = "msg_show", find = "more lines" },
				{ event = "msg_show", find = "^/" },
				{ event = "msg_show", find = "written" },
				{ event = "msg_show", find = "treesitter" },
				{ event = "notify", find = "Compilation completed" },
				{ event = "notify", find = "No information available" },
            },
          },
		  opts = { skip = true },
        },

		{
		  view = "notify",
          filter = {
            event = "notification",
			find = "Plugin Updates",
          },
		  opts = { skip = true },
		},
      },

	 --  popupmenu = {
		-- enabled = true, -- enables the Noice popupmenu UI
		-- ---@type 'nui'|'cmp'
		-- backend = "nui", -- backend to use to show regular cmdline completions
		-- ---@type NoicePopupmenuItemKind|false
		-- -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
		-- kind_icons = {}, -- set to `false` to disable icons
	 --  },

	  -- cmdline = {
		 --  enabled = true, -- enables the Noice cmdline UI
		 --  view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
		 --  opts = {}, -- global options for the cmdline. See section on views
		 --  ---@type table<string, CmdlineFormat>
		 --  format = {
			--   -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
			--   -- view: (default is cmdline view)
			--   -- opts: any options passed to the view
			--   -- icon_hl_group: optional hl_group for the icon
			--   -- title: set to anything or empty string to hide
			--   cmdline = {
			-- 	  pattern = "^:",
			-- 	  icon = "",
			-- 	  lang = "vim"
			--   },
			--   search_down = {
			-- 	  kind = "search",
			-- 	  pattern = "^/",
			-- 	  icon = " ",
			-- 	  lang = "regex"
			--   },
			--   search_up = {
			-- 	  kind = "search",
			-- 	  pattern = "^%?",
			-- 	  icon = " ",
			-- 	  lang = "regex"
			--   },
			--   filter = {
			-- 	  pattern = "^:%s*!",
			-- 	  icon = "$",
			-- 	  lang = "bash"
			--   },
			--   lua = {
			-- 	  pattern = {"^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*"},
			-- 	  icon = "",
			-- 	  lang = "lua"
			--   },
			--   help = {
			-- 	  pattern = "^:%s*he?l?p?%s+",
			-- 	  icon = ""
			--   },
			--   input = {} -- Used by input()
		 --  }
	  -- },

  --     presets = {
  --       bottom_search = true,
  --       command_palette = true,
  --       long_message_to_split = true,
  --       inc_rename = true,
		-- lsp_doc_border = true,
  --     },

	  notify = {
		  -- Noice can be used as `vim.notify` so you can route any notification like other messages
		  -- Notification messages have their level and other properties set.
		  -- event is always "notify" and kind can be any log level as a string
		  -- The default routes will forward notifications to nvim-notify
		  -- Benefit of using Noice for this is the routing and consistent history view
		  enabled = false,
		  view = "notify"
	  },
    },
    -- stylua: ignore
    -- keys = {
    --   { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    --   { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    --   { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
    --   { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
    --   { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    --   { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
    --   { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
    -- },
  },
}
