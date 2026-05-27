local gh = require("kuuga.helper.gh")
vim.pack.add({ { src = gh("wakatime/vim-wakatime"), version = vim.version.range("*") } })
require("wakatime").setup()
