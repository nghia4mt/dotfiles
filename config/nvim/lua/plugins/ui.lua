return {
  -- Theme Monokai
  {
    "tanvirtin/monokai.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme monokai]]
    end,
  },
  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup {
        options = { theme = "auto" },
      }
    end,
  },
}
