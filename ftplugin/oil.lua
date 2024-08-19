local keymap = require("kuuga.lib.keymap")

keymap.map("n", "<C-s>", "<cmd>write<CR>", "Quick save", { buffer = true })
