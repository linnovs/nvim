vim.g.mapleader = " " -- this should at the top most according to the behavior

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local kuuga = require("kuuga")
kuuga.init()

require("lazy").setup("plugins", {
	defaults = {
		version = "*",
	},
	checker = {
		enabled = true,
	},
})

kuuga.setup({
	colorscheme = "catppuccin",
})
