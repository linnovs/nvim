local keymap = require("kuuga.lib.keymap")

-- window management
keymap.map("n", "<Leader>ws", "<C-w>s", "Split window horizontally")
keymap.map("n", "<Leader>wv", "<C-w>v", "Split window vertically")
keymap.map("n", "<Leader>wn", "<C-w>n", "New empty file in a split")
keymap.map("n", "<Leader>wo", "<C-w>o", "Make the current window as the only one")
keymap.map("n", "<Leader>ww", "<C-w>w", "Cycle through windows")
keymap.map("n", "<Leader>wj", "<C-w>j", "Moves to window below")
keymap.map("n", "<Leader>wk", "<C-w>k", "Moves to window above")
keymap.map("n", "<Leader>wh", "<C-w>h", "Moves to window left")
keymap.map("n", "<Leader>wl", "<C-w>l", "Moves to window right")
keymap.map("n", "<Leader>wJ", "<C-w>J", "Move window to the very bottom")
keymap.map("n", "<Leader>wK", "<C-w>K", "Move window to the very top")
keymap.map("n", "<Leader>wH", "<C-w>H", "Move window to the far left")
keymap.map("n", "<Leader>wL", "<C-w>L", "Move window to the far right")
keymap.map("n", "<Leader>w=", "<C-w>=", "Make window equally high and wide (almost)")
keymap.map("n", "<Leader>w+", "<C-w>+", "Increase window height")
keymap.map("n", "<Leader>w-", "<C-w>-", "Decrease window height")
keymap.map("n", "<Leader>w<", "<C-w><", "Decrease window width")
keymap.map("n", "<Leader>w>", "<C-w>>", "Increase window width")
keymap.map("n", "<Leader>w|", "<C-w>|", "Make the window largest (not closing any)")
keymap.map("n", "<C-s>", "<cmd>update<CR>", "Quick save")
keymap.map("n", "<Leader>e", "<cmd>edit<CR>", "Quick re-edit")
keymap.map("n", "<Leader>qq", "<cmd>quit<CR>", "Quick quit")
keymap.map("n", "<Leader>qa", "<cmd>qall<CR>", "Quick quit all")
keymap.map("n", "<Leader>fqq", "<cmd>quit!<CR>", "Quick force quit")

-- clipboard management
-- stylua: ignore start
keymap.map({ "n", "v", "x" }, "<Leader>y", '"+y', "Yank to clipboard", { silent = true, noremap = true })
keymap.map({ "n", "v", "x" }, "<Leader>yy", '"+yy', "Yank link to clipboard", { silent = true, noremap = true })
keymap.map({ "n", "v", "x" }, "<Leader>Y", '"+Y', "Yank to clipboard", { silent = true, noremap = true })
keymap.map({ "n", "v", "x" }, "<Leader>p", '"+p', "Paste from clipboard", { silent = true, noremap = true })
keymap.map( "x", "<Leader>P", '"_dP', "Paste over selection without erasing unnamed register", { silent = true, noremap = true })
-- stylua: ignore end

keymap.map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", "Escape and clear hlsearch")

keymap.map("n", "<Leader>lazy", "<CMD>Lazy<CR>", "Open Lazy.nvim")
