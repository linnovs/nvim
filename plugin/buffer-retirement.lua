local gh = require("kuuga.helper.gh")
vim.pack.add({ gh("chrisgrieser/nvim-early-retirement") })
require("early-retirement").setup({})
