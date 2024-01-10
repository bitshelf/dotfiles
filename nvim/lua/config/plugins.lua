local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	require("config.plugins.telescope").config,
	-- require("config.plugins.coc"),
	require("config.plugins.comment"),
	require("config.plugins.colonize"),
	require("config.plugins.editor"),
	require("config.plugins.colorscheme"),
	require("config.plugins.copilot"),
	require("config.plugins.treesitter"),
	require("config.plugins.project"),
	require("config.plugins.tabline"),
	require("config.plugins.notify"),
	require("config.plugins.statusline"),
	-- require("config.plugins.scrollbar"),
	require("config.plugins.surround"),
	require("config.plugins.autocomplete").config,
	-- require("config.plugins.debugger"),
	require("config.plugins.lspconfig").config,
	require("config.plugins.joshuto"),
	require("config.plugins.wilder"),
	require("config.plugins.multi-cursor"),
	-- require("config.plugins.markdown"),
	require("config.plugins.git"),
	-- require("config.plugins.go"),
	require("config.plugins.indent"),
	require("config.plugins.yank"),
	require("config.plugins.undo"),
	require("config.plugins.winbar"),
	require("config.plugins.jump"),
	require("config.plugins.aosp"),
	require("config.plugins.vista"),
	require("config.plugins.terminal"),
	require("config.plugins.outline"),
	require("config.plugins.calltree"),
	require("config.plugins.autosave"),
	{ "dstein64/vim-startuptime" },

  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
})
