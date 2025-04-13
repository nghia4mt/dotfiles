return {
	'nvim-lualine/lualine.nvim',
	ependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		require("lualine").setup {
			options = {
				icon_enable = true,
				theme = "auto"
			}
		}
	end,

}
