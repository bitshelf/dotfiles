  return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      -- table.remove(opts.sections.lualine_c)
      table.remove(opts.sections.lualine_z)
    end,
  }
