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
	-- require("config.plugins.copilot"),
	require("config.plugins.treesitter"),
	require("config.plugins.project"),
	require("config.plugins.fzf"),
	require("config.plugins.tabline"),
	require("config.plugins.notify"),
	require("config.plugins.statusline"),
	require("config.plugins.scrollbar"),
	require("config.plugins.tabline"),
	require("config.plugins.autocomplete").config,
	require("config.plugins.debugger"),
	require("config.plugins.lspconfig").config,
	require("config.plugins.treesitter"),
	require("config.plugins.joshuto"),
	require("config.plugins.comment"),
	require("config.plugins.wilder"),
	require("config.plugins.multi-cursor"),
	require("config.plugins.copilot"),
	require("config.plugins.markdown"),
	require("config.plugins.git"),
	require("config.plugins.go"),
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
	{ "dstein64/vim-startuptime" },
}, {
})
