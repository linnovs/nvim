local gh = require("kuuga.helper.gh")
vim.pack.add({ gh("folke/tokyonight.nvim") })
require("tokyonight").setup({ style = "storm", transparent = true })
vim.cmd.colorscheme("tokyonight")
