return {
  -- 1. Format on Save (Conform)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = {
      -- Bạn chỉ cần khai báo CÁC CÔNG CỤ BÊN NGOÀI ĐẶC THÙ (như Prettier cho Web) ở đây.
      -- Với các ngôn ngữ mới (như Lua, Go, PHP...), bạn không cần khai báo gì cả,
      -- nó sẽ tự động dùng LSP để format.
      formatters_by_ft = {
        python = { "black" },
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        -- Tính năng hay: Tự động xóa khoảng trắng thừa ở cuối dòng cho MỌI file
        ["_"] = { "trim_whitespace" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
  },

  -- 2.(Gitsigns)
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = true,
      current_line_blame_opts = { delay = 500 },
    },
  },

  -- 3.(Treesitter)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter").setup {
        -- Chỉ giữ lại các ngôn ngữ cực kỳ cơ bản
        ensure_installed = { "c", "lua", "vim", "vimdoc" },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },
}
