local gh = require("kuuga.lib.pack-source.gh")
vim.schedule(function() vim.pack.add({ { src = gh("wakatime/vim-wakatime"), version = vim.version.range("*") } }) end)
