return {
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v3.x',
	dependencies = {
		-- LSP Support
		{ 'neovim/nvim-lspconfig' }, -- Required
		{              -- Optional
			'williamboman/mason.nvim',
			build = function()
				pcall(vim.cmd, 'MasonUpdate')
			end,
		},
		{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

		-- Autocompletion
		{ 'hrsh7th/nvim-cmp' }, -- Required
		{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
		{ 'L3MON4D3/LuaSnip' }, -- Required
	},
	config = function()
		-- Begin LSP SETUP --
		local lsp = require('lsp-zero').preset({})
		lsp.on_attach(function(client, bufnr)
			lsp.default_keymaps({ buffer = bufnr })
			lsp.buffer_autoformat()
		end)
		require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
		lsp.setup()
		-- End LSP  Setup --
		-- -----------------

		-- Begin CMP SETUP --
		local cmp = require('cmp')
		local cmp_action = require('lsp-zero').cmp_action()

		cmp.setup({
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = {
				['<Tab>'] = cmp_action.tab_complete(),
				['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
			},
		})
		-- End CMP Setup --
		-- ----------------

		-- Begin Mason Setup --
		require('mason').setup()
		require('mason-lspconfig').setup({
			ensure_installed = { 'tsserver', 'lua_ls' },
		})

		lsp.extend_cmp()

		require('lspconfig').tsserver.setup({
			on_attach = function(client, bufnr)
				lsp.default_keymaps({ buffer = bufnr })
			end
		})
		-- End Mason Setup --
	end,
}
