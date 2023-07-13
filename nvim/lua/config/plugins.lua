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
	--require("config.plugins.telescope").config,
	--require("config.plugins.coc"),
	require("config.plugins.colorscheme"),
	--require("config.plugins.scrollbar"),
	require("config.plugins.treesitter"),
	require("config.plugins.project"),
	require("config.plugins.fzf"),
	require("config.plugins.tabline"),
	require("config.plugins.notify"),
	require("config.plugins.statusline"),
	require("config.plugins.git"),
	require("config.plugins.wilder"),
	require("config.plugins.winbar"),
	require("config.plugins.indent"),
}, {
})

require("plugin.vertical_cursor_movement")
require("plugin.compile_run")
