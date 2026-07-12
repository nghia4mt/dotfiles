---==========================================================
----------- 1. Autopair
---==========================================================
return {
  {
    "nvim-mini/mini.pairs",
    version = "*",
    config = function()
      require("mini.pairs").setup()
    end,
  },
  ---==========================================================
  ----------- 2. Comment
  ---==========================================================
  {
    {
      "nvim-mini/mini.comment",
      version = false,
      config = function()
        require("mini.comment").setup(opts)
        -- Ctrl + / (normal mode)
        vim.keymap.set("n", "<C-/>", "gcc", { remap = true, desc = "Toggle Comment" })
        vim.keymap.set("n", "<C-_>", "gcc", { remap = true, desc = "Toggle Comment (Terminal Fix)" })

        -- Ctrl + / (Visual mode)
        vim.keymap.set("v", "<C-/>", "gc", { remap = true, desc = "Toggle Comment" })
        vim.keymap.set("v", "<C-_>", "gc", { remap = true, desc = "Toggle Comment (Terminal Fix)" })
      end,
    },
  },
  ---==========================================================
  ----------- 2. Comment
  ---==========================================================
  {
    {
      "nvim-mini/mini.indentscope",
      version = false,
      config = function()
        require("mini.indentscope").setup()
      end,
    },
  },
}
