  return {
    "nvim-lualine/lualine.nvim",
	event = "LazyFile",
    opts = function(_, opts)
      table.remove(opts.sections.lualine_x)
      table.remove(opts.sections.lualine_z)
    end,
  }
