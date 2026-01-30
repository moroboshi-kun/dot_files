-- ============================================================
-- Core Options (Vim parity)
-- ============================================================

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.laststatus = 2

-- Indentation
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.autoindent = true
opt.smartindent = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"

-- Syntax / filetypes
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

-- Leader
vim.g.mapleader = " "

