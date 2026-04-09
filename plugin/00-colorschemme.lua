local gh = require("kuuga.lib.pack-source.gh")
vim.pack.add({ gh("folke/tokyonight.nvim") })
require("tokyonight").setup({ style = "storm", transparent = true })
vim.cmd.colorscheme("tokyonight")
