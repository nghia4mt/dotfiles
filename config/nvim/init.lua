-- ===========================================================================
-- 1. Basic Config
-- ===========================================================================
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath "data" .. "/undo"

-- ===========================================================================
-- 2. Lazy Plugin Loader
-- ===========================================================================
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

-- ===========================================================================
-- 3. Load all plugins in the `lua/plugins/` folder
-- ===========================================================================
require("lazy").setup "plugins"

-- ===========================================================================
-- 4. Keymaps
-- ===========================================================================
local map = vim.keymap.set

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })

-- Window management
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close current window" })

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>x", "<cmd>bd<cr>", { desc = "Close current buffer" })

-- File explorer
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })

-- Quick actions
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Exit nvim" })
map("n", "<leader>s", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "New buffer" })
map("n", "<leader>bb", "<cmd>b#<cr>", { desc = "Switch to alternate buffer" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>noh<cr>", { desc = "Clear search highlight" })

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", "<cmd>m '>+1<CR>gv", { desc = "Move selection down" })
map("v", "<A-k>", "<cmd>m '<-2<CR>gv", { desc = "Move selection up" })

-- Comment toggle
map("n", "<C-/>", "gcc", { remap = true, desc = "Toggle comment" })
map("v", "<C-/>", "gc", { remap = true, desc = "Toggle comment" })
map("n", "<C-_>", "gcc", { remap = true, desc = "Toggle comment (Terminal Fix)" })
map("v", "<C-_>", "gc", { remap = true, desc = "Toggle comment (Terminal Fix)" })
