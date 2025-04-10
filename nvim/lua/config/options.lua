-- vim.g.lazyvim_picker = "telescope"
vim.g.lazyvim_picker = "fzf"
vim.g.root_spec = { "lsp", {".repo", ".git", "lua" }, "cwd" }
vim.g.autoformat = false
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

vim.o.termguicolors = true
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

vim.o.ttyfast = true
vim.o.exrc = true
vim.o.number = false
vim.o.relativenumber = false
-- vim.o.secure = false
-- vim.o.cursorline = true

vim.o.signcolumn = "yes"
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = false
vim.o.tabstop = 4
vim.o.smarttab = true
vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.o.ttimeoutlen = 0
vim.o.smartcase = true -- Don't ignore case with capitals
vim.o.smartindent = true -- Insert indents automatically
-- vim.o.timeout = false
vim.o.viewoptions = "cursor,folds,slash,unix"
vim.o.wrap = false
vim.o.textwidth = 0
vim.o.indentexpr = ""
-- vim.o.foldmethod = 'indent'
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.ignorecase = true
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.inccommand = "split"
vim.o.completeopt = "longest,noinsert,menuone,noselect,preview"
vim.o.completeopt = "menuone,noinsert,noselect,preview"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.o.lazyredraw = true
vim.o.updatetime = 100
vim.o.virtualedit = "block"
vim.o.list = false
vim.o.cmdheight = 0
vim.o.scrolloff = 2
vim.o.mouse = "ni"
vim.o.encoding = "utf-8"
vim.g.indent_blankline_enabled = 0
vim.opt.clipboard = "" -- Don't merge default yank register with OS clipboard
vim.opt.listchars = "tab:▸ ,trail:·,nbsp:␣,extends:❯,precedes:❮" -- trail:●
vim.g.python3_host_prog = "python" or "$HOME/miniconda3/bin/python3"
vim.opt.signcolumn = "yes"
vim.o.autoread = true
vim.bo.autoread = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.autochdir = false
vim.opt.swapfile = false
-- vim.opt.guicursor:append("n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50")
-- vim.opt.guicursor:append("a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor")
-- vim.opt.guicursor:append("sm:block-blinkwait175-blinkoff150-blinkon175")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = false,
  virtual_text = false,
  signs = false,
  update_in_insert = false,
})

-- make all keymaps silent by default
local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end
