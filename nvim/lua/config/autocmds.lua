-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({ "FileType" }, {
	-- pattern = { "lua" },
	callback = function()
		-- Disable autoformat for all files
		vim.b.autoformat = false
		-- Don't have `o` add a comment
		vim.opt.formatoptions:remove "o"
	end,
})

-- vim.cmd([[
-- 	autocmd FileType * set formatoptions-=o
-- ]])

vim.cmd([[
	silent !mkdir -p $HOME/.config/nvim/tmp/backup
	silent !mkdir -p $HOME/.config/nvim/tmp/undo
	"silent !mkdir -p $HOME/.config/nvim/tmp/sessions
	set backupdir=$HOME/.config/nvim/tmp/backup,.
	set directory=$HOME/.config/nvim/tmp/backup,.
	if has('persistent_undo')
		set undofile
		set undodir=$HOME/.config/nvim/tmp/undo,.
	endif
]])
