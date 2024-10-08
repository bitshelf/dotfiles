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

-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = nil
    end
  end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
})

vim.filetype.add({
  extension = {
    h = "c",
    scheme = "scheme",
    overlay = "dts",
    keymap = "dts",
  },
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  callback = function()
    vim.cmd([[Trouble qflist open]])
  end,
})

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

-- vim.cmd([[
-- 	autocmd FileType * set formatoptions-=o
-- ]])
