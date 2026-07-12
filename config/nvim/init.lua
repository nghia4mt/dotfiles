-- 1. Basic Config
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.opt.undofile = true

-- 2. DOWNLOAD LAZY PLUGIN
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

-- 3. AUTOMATICALLY LOAD ALL PLUGINS IN THE FOLDER `lua/plugins/`
require("lazy").setup "plugins"

-- 4. Keymaps
local map = vim.keymap.set
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Exit nvim" })
map("n", "<leader>s", "<cmd>w<cr>", { desc = "Save file" })
