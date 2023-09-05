require("config.lazy")
local opt = vim.opt
opt.number = true                                 -- Show line number
opt.clipboard = "unnamedplus"                     -- Sync clipboard
opt.undofile = true                               -- Enable undofile
opt.undolevels = 10000                            -- Set level undofile
--opt.undodir = os.getenv("HOME") .. "/.cache/nvim" -- Set location cache undo
opt.background = "dark"                           -- or "light" for light mode

--netrw
vim.api.nvim_set_keymap('n', '<leader>b', ':Lex<CR>', { noremap = true, silent = true })
vim.cmd('let g:netrw_winsize=25')

--Code_runner
vim.keymap.set('n', '<leader>r', ':RunCode<CR>', { noremap = true, silent = false })
