local keymap = require("kuuga.lib.keymap")

keymap.map(
	"n",
	"<leader>tv",
	"<CMD>lua require('kulala').toggle_view()<CR>",
	"Toggle view",
	{ noremap = true, silent = true }
)
keymap.map("n", "[", "<CMD>lua require('kulala').jump_prev()<CR>", "Prev request", { noremap = true, silent = true })
keymap.map("n", "]", "<CMD>lua require('kulala').jump_next()<CR>", "Next request", { noremap = true, silent = true })
keymap.map("n", "<CR>", "<CMD>lua require('kulala').run()<CR>", "Run request", { noremap = true, silent = true })
