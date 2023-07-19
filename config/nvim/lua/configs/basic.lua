vim.opt.number = true -- Show line number
vim.opt.clipboard = "unnamedplus" -- Sync clipboard
vim.opt.undofile = true -- Enable undofile
vim.opt.undolevels = 10000 -- Set level undofile
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim" -- Set location cache undo
vim.o.background = "dark" -- or "light" for light mode

