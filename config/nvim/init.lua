require "core.options"

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
	spec = {
	{ import = "core.theme" },
	{ import = "plugins" },
	-- import extras plugins lazy
	{ import = "plugins.lsp.lsp" },
	}
})
