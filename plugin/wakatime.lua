local gh = require("kuuga.helper.gh")
vim.schedule(function() vim.pack.add({ { src = gh("wakatime/vim-wakatime"), version = vim.version.range("*") } }) end)
