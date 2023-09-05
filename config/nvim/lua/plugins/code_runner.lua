return {
	{
		"CRAG666/code_runner.nvim",
		config = function()
			require('code_runner').setup({
				filetype = {
					java = {
						"cd $dir &&",
						"javac $fileName &&",
						"java $fileNameWithoutExt"
					},
					python = "python3 -u",
					typescript = "deno run",
					javascript = "node",
				},
				project_path = "",
				project = {},
				prefix = "",
			})
		end,
		keys = {
			{ "<leader>r",  "<cmd>RunCode<cr>" },
			{ "<leader>rc", "<cmd>RunClose<cr>" },
		},
	},
}
