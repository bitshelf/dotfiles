return {
  "nvim-treesitter/playground",
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    priority = 1000,
    build = ":TSUpdate",
    auto_install = true,
    config = function()
      require("nvim-treesitter.configs").setup({

        ensure_installed = {
          "c",
          "cpp",
          "rust",
          "kotlin",
          "java",
          "markdown",
          "json",
          "vimdoc",
          "vim",
          "bash",
          "lua",
          "devicetree",
          "blueprint",
          "gn",
          "query",
          "kdl",
          "python",
          "yaml",
        },

        highlight = {
          enable = true,
          --disable = { "devicetree",}, -- list of language that will be disabled
          disable = function(lang, buf)
            local max_filesize = 50 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-m>",
            node_incremental = "<c-m>",
            node_decremental = "<c-h>",
            scope_incremental = "<c-l>",
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      local tscontext = require("treesitter-context")
      tscontext.setup({
        enable = true,
        max_lines = 2, -- How many lines the window should span. Values <= 0 mean no limit
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
        trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      })
      vim.keymap.set("n", "[c", function()
        tscontext.go_to_context()
      end, { silent = true })
    end,
  },
}
