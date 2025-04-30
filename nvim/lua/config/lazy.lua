-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- import any extras modules here
    { import = "lazyvim.plugins.extras.lang.clangd" },
    -- { import = "lazyvim.plugins.extras.lang.java" },
    -- { import = "lazyvim.plugins.extras.lang.rust" },

    { import = "lazyvim.plugins.extras.coding.yanky" },
	{ import = "lazyvim.plugins.extras.editor.aerial" },
	{ import = "lazyvim.plugins.extras.ui.treesitter-context" },
	{ import = "lazyvim.plugins.extras.ui.mini-indentscope" },
	-- { import = "lazyvim.plugins.extras.editor.telescope" },
    -- { import = "lazyvim.plugins.extras.coding.luasnip" },

    -- import/override with your plugins
    { import = "plugins" },
  },

  pkg = {
    enabled = true,
    cache = vim.fn.stdpath("state") .. "/lazy/pkg-cache.lua",
    -- the first package source that is found for a plugin will be used.
    sources = {
      "lazy",
      "rockspec", -- will only be used when rocks.enabled is true
      "packspec",
    },
  },

  defaults = {
    version = "*", -- try installing the latest stable version for plugins that support semver
  },

  install = { colorscheme = { "tokyonight" } },
  checker = {
		enabled = true,
		notify = false,
	},

 --  ui = {
	-- icons = {
	-- 	cmd = "⌘",
	-- 	config = "🛠",
	-- 	event = "📅",
	-- 	ft = "📂",
	-- 	init = "⚙",
	-- 	keys = "🗝",
	-- 	plugin = "🔌",
	-- 	runtime = "💻",
	-- 	require = "🌙",
	-- 	source = "📄",
	-- 	start = "🚀",
	-- 	task = "📌",
	-- 	lazy = "💤 ",
	-- },
 --  },

  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    notify = false, -- get a notification when changes are found
  },
})
