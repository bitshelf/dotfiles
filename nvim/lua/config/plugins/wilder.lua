return {{
    'gelguy/wilder.nvim',
    -- enabled = false,
    event = "VimEnter",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
        local wilder = require('wilder')
        wilder.setup {
            modes = {':'},
            next_key = '<Tab>',
            previous_key = '<S-Tab>'
        }
        wilder.set_option('renderer', wilder.popupmenu_renderer(
            wilder.popupmenu_palette_theme({
                highlights = {
                    border = 'Normal' -- highlight to use for the border
                },
                left = {' ', wilder.popupmenu_devicons()},
                right = {' ', wilder.popupmenu_scrollbar()},
                border = 'rounded',
                max_height = '75%', -- max height of the palette
                min_height = 0, -- set to the same as 'max_height' for a fixed height window
                prompt_position = 'top', -- 'top' or 'bottom' to set the location of the prompt
                reverse = 0 -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
            })))
        wilder.set_option('pipeline', {wilder.branch(wilder.cmdline_pipeline({
            language = 'vim',
            fuzzy = 1
        }), wilder.search_pipeline())})
    end
}, {
    "folke/noice.nvim",
    -- event = "VeryLazy",
    event = "VimEnter",
    -- enabled = false,

    dependencies = { -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim", -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify"},

    opts = {
        lsp = {
            progress = {
                enabled = true
            }
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

        routes = {{
            filter = {
                event = "msg_show",
                any = {{
                    find = "%d+L, %d+B"
                }, {
                    find = "; after #%d+"
                }, {
                    find = "; before #%d+"
                }}
            },
            view = "mini"
        }},

        cmdline = {
            enabled = false, -- enables the Noice cmdline UI
            view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
            opts = {}, -- global options for the cmdline. See section on views
            ---@type table<string, CmdlineFormat>
            format = {
                -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
                -- view: (default is cmdline view)
                -- opts: any options passed to the view
                -- icon_hl_group: optional hl_group for the icon
                -- title: set to anything or empty string to hide
                cmdline = {
                    pattern = "^:",
                    icon = "",
                    lang = "vim"
                },
                search_down = {
                    kind = "search",
                    pattern = "^/",
                    icon = " ",
                    lang = "regex"
                },
                search_up = {
                    kind = "search",
                    pattern = "^%?",
                    icon = " ",
                    lang = "regex"
                },
                filter = {
                    pattern = "^:%s*!",
                    icon = "$",
                    lang = "bash"
                },
                lua = {
                    pattern = {"^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*"},
                    icon = "",
                    lang = "lua"
                },
                help = {
                    pattern = "^:%s*he?l?p?%s+",
                    icon = ""
                },
                input = {} -- Used by input()
                -- lua = false, -- to disable a format, set to `false`
            }
        },

        notify = {
            -- Noice can be used as `vim.notify` so you can route any notification like other messages
            -- Notification messages have their level and other properties set.
            -- event is always "notify" and kind can be any log level as a string
            -- The default routes will forward notifications to nvim-notify
            -- Benefit of using Noice for this is the routing and consistent history view
            enabled = false,
            view = "notify"
        },

        presets = {
            bottom_search = true,
            command_palette = false,
            long_message_to_split = true,
            inc_rename = true
        }
    },
    -- stylua: ignore
    keys = {{
        "<S-Enter>",
        function()
            require("noice").redirect(vim.fn.getcmdline())
        end,
        mode = "c",
        desc = "Redirect Cmdline"
    }, {
        "<leader>snl",
        function()
            require("noice").cmd("last")
        end,
        desc = "Noice Last Message"
    }, {
        "<leader>snh",
        function()
            require("noice").cmd("history")
        end,
        desc = "Noice History"
    }, {
        "<leader>sna",
        function()
            require("noice").cmd("all")
        end,
        desc = "Noice All"
    }, {
        "<leader>snd",
        function()
            require("noice").cmd("dismiss")
        end,
        desc = "Dismiss All"
    }, {
        "<c-f>",
        function()
            if not require("noice.lsp").scroll(4) then
                return "<c-f>"
            end
        end,
        silent = true,
        expr = true,
        desc = "Scroll forward",
        mode = {"i", "n", "s"}
    }, {
        "<c-b>",
        function()
            if not require("noice.lsp").scroll(-4) then
                return "<c-b>"
            end
        end,
        silent = true,
        expr = true,
        desc = "Scroll backward",
        mode = {"i", "n", "s"}
    }}
}}
