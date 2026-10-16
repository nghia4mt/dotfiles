return {
    -- 1. Autopair
    {
        "nvim-mini/mini.pairs",
        version = "*",
        config = function()
            require("mini.pairs").setup()
        end,
    },

    -- 2. Comment
    {
        "nvim-mini/mini.comment",
        version = false,
        config = function()
            require("mini.comment").setup()
        end,
    },

    -- 3. Indentscope
    {
        "nvim-mini/mini.indentscope",
        version = false,
        config = function()
            require("mini.indentscope").setup()
        end,
    },
}
