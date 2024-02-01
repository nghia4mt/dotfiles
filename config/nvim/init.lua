require("config.lazy")
require("plugins.coc")

vim.opt.number = true --show line number
vim.opt.clipboard = "unnamedplus" --sync clipboard
vim.opt.undofile = true --enable undo file
vim.opt.undolevels = 1000
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim" -- Set location cache undo
vim.opt.background = "dark"
