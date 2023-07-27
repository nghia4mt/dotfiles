return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle" },
	build = "cd app && npm install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
		vim.g.mkdp_auto_start = 0
		vim.g.mkdp_auto_close = 1
		vim.g.mkdp_refresh_slow = 0
		vim.g.mkdp_command_for_global = 0
		vim.g.mkdp_echo_preview_url = 0
		vim.g.mkdp_browser = 'firefox'
	end,
	ft = { "markdown" },
}
