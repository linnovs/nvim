local gh = require("kuuga.helper.gh")
vim.g.loaded_wakatime = true
vim.pack.add({ { src = gh("wakatime/vim-wakatime") } })
require("wakatime").setup({
	debug = false,
})
