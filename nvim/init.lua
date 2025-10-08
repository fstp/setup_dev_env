-- Bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- This has to be set before initializing lazy
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Initialize lazy with dynamic loading of anything in the plugins directory
require("lazy").setup("plugins", {
   change_detection = {
    enabled = true, -- automatically check for config file changes and reload the ui
    notify = false, -- turn off notifications whenever plugin changes are made
  },
})

-- These modules are not loaded by lazy
require("core.options")
require("core.keymaps")

-- Color for the Lsp symbol highlight
vim.api.nvim_set_hl(0, 'LspReferenceRead', {fg = "#81B69D"})
vim.api.nvim_set_hl(0, 'LspReferenceWrite', {fg = "#81B69D"})
vim.api.nvim_set_hl(0, 'LspReferenceText', {fg = "#81B69D"})

-- Color the split separator with bright orange to make it more visible
vim.api.nvim_set_hl(0, 'WinSeparator', {fg = "#E19400"})

vim.cmd([[
augroup highlight_yank
  autocmd! TextYankPost
  autocmd TextYankPost * silent! lua vim.hl.on_yank({higroup = "IncSearch", timeout = 500})
augroup END
]])

-- Allow project specific .nvim.lua config files
vim.opt.exrc = true
