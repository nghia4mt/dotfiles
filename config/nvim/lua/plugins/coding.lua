return {
    -- 1. Format on Save (Conform)
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        opts = {
            formatters_by_ft = {
                python = { "black" },
                lua = { "stylua" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
                ["_"] = { "trim_whitespace" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        },
    },

    -- 2. Gitsigns
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            current_line_blame = true,
            current_line_blame_opts = { delay = 500 },
        },
    },

    -- 3. Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-treesitter").setup {
                ensure_installed = {
                    "c",
                    "lua",
                    "vim",
                    "vimdoc",
                    "python",
                    "javascript",
                    "typescript",
                    "yaml",
                    "json",
                    "html",
                    "css",
                    "bash",
                    "markdown",
                    "markdown_inline",
                },
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
            }
        end,
    },

    -- 4. Markdown preview
    {
        "iamcco/markdown-preview.nvim",
        ft = { "markdown" },
        keys = {
            { "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview" },
            { "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", desc = "Stop Preview" },
        },
        config = function()
            vim.g.mkdp_auto_close = 1
            vim.g.mkdp_auto_open = 0
            vim.g.mkdp_refresh_slow = 0
            vim.g.mkdp_port = 8080
            vim.g.mkdp_page_title = "${name}"
            vim.g.mkdp_preview_options = {
                toc = { auto_show = 0, auto_refresh = 1, depth = 6 },
            }
        end,
        -- Cross-platform build: prefer install.sh on Unix, install.cmd on Windows.
        build = function()
            local app = vim.fn.stdpath "data" .. "/lazy/markdown-preview.nvim/app"
            if package.config:sub(1, 1) == "\\" then
                vim.fn.system { cmd = "cmd", args = { "/c", "cd", "/d", app, "&& install.cmd" } }
            else
                vim.fn.system { cmd = "sh", args = { "-c", "cd " .. app .. " && ./install.sh" } }
            end
        end,
    },
}
