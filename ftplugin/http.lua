local keymap = require("kuuga.lib.keymap")

keymap.map("n", "<C-j>", "<CMD>lua require('kulala').jump_prev()<CR>", { noremap = true, silent = true })
keymap.map("n", "<C-k>", "<CMD>lua require('kulala').jump_next()<CR>", { noremap = true, silent = true })
keymap.map("n", "<C-l>", "<CMD>lua require('kulala').run()<CR>", { noremap = true, silent = true })
