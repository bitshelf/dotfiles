vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.o.termguicolors = true
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

vim.o.ttyfast = true
vim.o.exrc = true
vim.o.secure = false
vim.o.listchars = 'tab:|\\ ,trail:▫'
--vim.o.number = true
--vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.signcolumn="yes"
vim.o.expandtab = false
vim.o.tabstop = 4
vim.o.smarttab = true
vim.o.shiftwidth = 2
vim.o.autoindent = true
vim.o.ttimeoutlen = 0
vim.o.timeout = false
vim.o.viewoptions = 'cursor,folds,slash,unix'
vim.o.wrap = false
vim.o.textwidth = 0
vim.o.indentexpr = ''
-- vim.o.foldmethod = 'indent'
vim.o.formatoptions = vim.o.formatoptions:gsub('tc', '')
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.showmode = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.inccommand = 'split'
vim.o.completeopt = 'longest,noinsert,menuone,noselect,preview'
vim.o.completeopt = 'menuone,noinsert,noselect,preview'
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.o.lazyredraw = true
vim.o.updatetime = 100
vim.o.virtualedit = 'block'
vim.o.list = false
vim.o.cmdheight = 0
vim.o.scrolloff = 2
vim.o.mouse = "ni"
vim.o.encoding = "utf-8"
vim.g.indent_blankline_enabled = 0
vim.g.python3_host_prog = '$HOME/miniconda3/bin/python3'
vim.opt.signcolumn = "yes"
vim.o.autoread = true
vim.bo.autoread = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.autochdir = false
vim.opt.swapfile = false
-- vim.opt.guicursor:append('n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50')
-- vim.opt.guicursor:append('a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor')
-- vim.opt.guicursor:append('sm:block-blinkwait175-blinkoff150-blinkon175')
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
    signs = false,
    update_in_insert = false,
  }
)
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     signs = {
--       severity_limit = "Hint",
--     },
--     virtual_text = {
--       severity_limit = "Warning",
--     },
--   }
-- )

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

-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.md", command = "setlocal spell", })
-- vim.api.nvim_create_autocmd("BufEnter", { pattern = "*", command = "silent! lcd %:p:h", })

vim.cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])

-- Highlight yanked text
local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup
---Highlight the texts when you yanked
au("TextYankPost", {
	group = ag("yank_highlight", {}),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
	end,
})

vim.cmd([[autocmd TermOpen term://* startinsert]])
vim.cmd([[autocmd FileType * set formatoptions-=o]])
vim.cmd([[
augroup NVIMRC
    autocmd!
    autocmd BufWritePost .vim.lua exec ":so %"
augroup END
tnoremap <C-N> <C-\><C-N>
tnoremap <C-O> <C-\><C-N><C-O>
]])
