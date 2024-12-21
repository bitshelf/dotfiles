local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- import any extras modules here
	-- { import = "lazyvim.plugins.extras.editor.telescope" },
    { import = "lazyvim.plugins.extras.lang.clangd" },
    { import = "lazyvim.plugins.extras.coding.yanky" },
    -- { import = "lazyvim.plugins.extras.coding.luasnip" },
	{ import = "lazyvim.plugins.extras.editor.aerial" },
	{ import = "lazyvim.plugins.extras.ui.treesitter-context" },
	{ import = "lazyvim.plugins.extras.ui.mini-indentscope" },
    -- { import = "lazyvim.plugins.extras.lang.java" },
    -- { import = "lazyvim.plugins.extras.lang.rust" },

    -- import/override with your plugins
    { import = "plugins" },
  },

  pkg = {
    enabled = true,
    cache = vim.fn.stdpath("state") .. "/lazy/pkg-cache.lua",
    -- the first package source that is found for a plugin will be used.
    sources = {
      "lazy",
      "rockspec", -- will only be used when rocks.enabled is true
      "packspec",
    },
  },

  rocks = {
    enabled = false,
    root = vim.fn.stdpath("data") .. "/lazy-rocks",
    server = "https://nvim-neorocks.github.io/rocks-binaries/",
  },

  defaults = {
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    -- version = false, -- always use the latest git commit
    version = "*", -- try installing the latest stable version for plugins that support semver
  },

  install = { colorscheme = { "tokyonight", "habamax" } },

  checker = {
	enabled = true,
	notify = false,
  }, -- automatically check for plugin updates

  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    notify = false, -- get a notification when changes are found
  },

  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },

})
