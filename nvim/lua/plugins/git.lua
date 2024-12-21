return {
	{
		"lewis6991/gitsigns.nvim",
		enabled = vim.fn.executable "git" == 1,
		event = "LazyFile",

		opts = {
			signs_staged_enable = true,
		},

	}
}
