require "options"


-- bootstrap plugins & lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim" -- path where its going to be installed

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	}
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({


	{ lazy = true, "nvim-lua/plenary.nvim" },

	{
		"loctvl842/monokai-pro.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme monokai-pro-classic]])
		end,
	},

	-- file tree
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		config = function()
			require("nvim-tree").setup()
		end,
	},

	-- icons, for UI related plugins
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup()
		end,
	},

	-- syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require "plugins.treesitter"
		end,
	},

	-- buffer + tab line
	{
		"akinsho/bufferline.nvim",
		event = "BufReadPre",
		config = function()
			require "plugins.bufferline"
		end,
	},

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup {
				options = {
					icon_enable = true,
					theme = "auto",
				},
			}
		end,
	},

	-- we use cmp plugin only when in insert mode
	-- so lets lazyload it at InsertEnter event, to know all the events check h-events
	-- completion , now all of these plugins are dependent on cmp, we load them after cmp
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- cmp sources
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",

			-- snippets
			--list of default snippets
			"rafamadriz/friendly-snippets",

			-- snippets engine
			{
				"L3MON4D3/LuaSnip",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},

			-- autopairs , autocompletes ()[] etc
			{
				"windwp/nvim-autopairs",
				config = function()
					require("nvim-autopairs").setup()

					--  cmp integration
					local cmp_autopairs = require "nvim-autopairs.completion.cmp"
					local cmp = require "cmp"
					cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},
		},
		config = function()
			require "plugins.cmp"
		end,
	},

	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		cmd = { "Mason", "MasonInstall" },
		config = function()
			require("mason").setup {}
		end,
	},

	-- lsp
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require "plugins.lspconfig"
		end,
	},

	-- formatting , linting
	{
		"stevearc/conform.nvim",
		lazy = true,
		config = function()
			require "plugins.conform"
		end,
	},

	-- indent lines
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("ibl").setup()
		end,
	},

	-- files finder etc
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		config = function()
			require "plugins.telescope"
		end,
	},

	-- git status on signcolumn etc
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup()
		end,
	},

	-- comment plugin
	{
		"numToStr/Comment.nvim",
		lazy = true,
		config = function()
			require("Comment").setup()
		end,
	},

})
