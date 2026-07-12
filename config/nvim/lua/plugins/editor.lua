return {
    -- Find file (Telescope)
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Tìm File" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Tìm chữ trong Code" },
        },
    },

    --(Neo-tree)
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { "<leader>e", "<cmd>Neotree toggle left<cr>", desc = "on/off Sidebar" },
        },
        opts = {
            filesystem = {
                filtered_items = { visible = true }, -- Show file hidden (.gitignore, .env...)
            }
        }
    },
}
