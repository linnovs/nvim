local map = require("kuuga.lib.keymap")

map("n", "<C-s>", "<cmd>write<CR>", "Quick save", { buffer = true })
