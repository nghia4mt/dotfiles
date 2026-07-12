return {
    -- 1. ENGINE GỢI Ý CODE (Blink.cmp)
    {
        "Saghen/blink.cmp",
        version = "*",
        build = "cargo build --release",
        opts = {
            snippets = { preset = 'default' },
            keymap = {
                preset = 'default',
                ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-e>'] = { 'hide' },
                ['<CR>'] = { 'accept', 'fallback' },
                -- Phím tắt Tab nhảy gợi ý giống VS Code
                ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
                ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
            },
            sources = { default = { 'lsp' } },
        },
    },

    -- 2. Config Lsp
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "Saghen/blink.cmp",
        },
        config = function()
            require("mason").setup()

            local mason_lspconfig = require("mason-lspconfig")

            mason_lspconfig.setup({
                ensure_installed = { "pyright", "ts_ls", "html", "cssls" },
                automatic_installation = true,
            })

            local capabilities = require('blink.cmp').get_lsp_capabilities()

            -- [CẬP NHẬT FIX LỖI NIL]: Lấy danh sách toàn bộ LSP đã cài đặt bằng Mason
            local installed_servers = mason_lspconfig.get_installed_servers()

            -- Tự động cấu hình và kích hoạt toàn bộ bằng API Native
            for _, lsp in ipairs(installed_servers) do
                vim.lsp.config(lsp, {
                    capabilities = capabilities,
                })
                vim.lsp.enable(lsp)
            end

            -- Phím tắt LSP
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(e)
                    local opts = { buffer = e.buf }
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                end,
            })
        end,
    },
}
