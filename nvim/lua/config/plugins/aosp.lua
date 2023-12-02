return {
  	{
	  "lzap/vim-selinux",
	  ft = "te",
	  -- enabled = false,
	},
	{
	  "bitshelf/aosp-vim",
	  ft = {"bp","hal" },
	},
	{
	  'google/vim-maktaba',
	},
	{
	  -- 'kalcutter/vim-gn',
	  'https://gn.googlesource.com/gn',
	  config = function(plugin)
		  -- vim.opt.rtp:append("~/.local/share/nvim/lazy/gn/misc/vim/")
		  vim.opt.rtp:append(plugin.dir ..  "/misc/vim")
	  end
	},
	-- {
	--   'bazelbuild/vim-bazel'
	-- },
}
