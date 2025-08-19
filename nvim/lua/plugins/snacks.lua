return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    words = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    styles = {
      notification = {
        wo = { wrap = true } -- Wrap notifications
      }
    },
  },

  keys = {
	-- Top Pickers & Explorer
	{ "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
	{ "<leader>ef", function() Snacks.explorer() end, desc = "File Explorer" },
	-- git
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
    { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
    { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
	{ "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
	-- search
	{ '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
	{ "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
	{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
	{ "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
	-- Other
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<leader>cR", function() Snacks.rename() end, desc = "Rename File" },
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
    { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
    { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
  },
}
