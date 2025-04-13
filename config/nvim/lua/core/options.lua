-- Basic config -- 
------------------
vim.g.mapleader = " "
vim.opt.number = true --show line number
vim.opt.clipboard = "unnamedplus" --sync clipboard
vim.opt.undofile = true --enable undo file
vim.opt.undolevels = 1000
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim" -- Set location cache undo
vim.opt.background = "dark"

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath "data" .. "/mason/bin"


---- Key binding ----
local map = vim.keymap.set

-- general mappings
map("n", "<C-s>", "<cmd> w <CR>")
map("i", "jk", "<ESC>")


