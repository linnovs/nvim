local gh = require("kuuga.helper.gh")
vim.pack.add({ gh("folke/tokyonight.nvim") })
require("tokyonight").setup({
	style = "storm",
	transparent = true,
	on_colors = function(colors) colors.border = "#0a0b10" end,
})
vim.cmd.colorscheme("tokyonight")
