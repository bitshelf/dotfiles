return {
  "ahmedkhalf/project.nvim",
    config = function()
	local opts = {silent = true, nowait = true}
	vim.keymap.set('n', '<leader>gi', ':ProjectRoot<cr>', opts)
	vim.keymap.set("n", "<leader>.", ":cd %:p:h<cr>", opts)

	-- Open new file adjacent to current file
	vim.cmd([[
		nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
	]])

    require("project_nvim").setup {
		-- Manual mode doesn't automatically change your root directory, so you have
		-- the option to manually do so using `:ProjectRoot` command.
		manual_mode = true,

		-- Methods of detecting the root directory. **"lsp"** uses the native neovim
		-- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
		-- order matters: if one is not detected, the other is used as fallback. You
		-- can also delete or rearangne the detection methods.
		detection_methods = { "pattern","lsp" },

		-- All the patterns used to detect root dir, when **"pattern"** is in
		-- detection_methods
		patterns = { ".git" },

		-- Table of lsp clients to ignore by name
		-- eg: { "efm", ... }
		ignore_lsp = {},

		-- Don't calculate root dir on specific directories
		-- Ex: { "~/.cargo/*", ... }
		exclude_dirs = {},

		-- Show hidden files in telescope
		show_hidden = true,

		-- When set to false, you will get a message when project.nvim changes your
		-- directory.
		silent_chdir = true,

		-- What scope to change the directory, valid options are
		-- * global (default)
		-- * tab
		-- * win
		scope_chdir = 'global',

		-- Path where project.nvim will store the project history for use in
		-- telescope
		datapath = vim.fn.stdpath("data"),
    }
	end
	-- {
	-- 	"airblade/vim-rooter",
	-- 	init = function()
	-- 		vim.g.rooter_patterns = { '__vim_project_root', '.git/' }
	-- 		vim.g.rooter_silent_chdir = true
	-- 		-- set an autocmd
	-- 		vim.api.nvim_create_autocmd("VimEnter", {
	-- 			pattern = "*",
	-- 			callback = function()
	-- 				-- source .nvim.lua at project root
	-- 				vim.cmd([[silent! source .vim.lua]])
	-- 			end,
	-- 		})
	-- 	end
	-- },
}
