local keymap = require("kuuga.lib.keymap")

-- window navigation
keymap("n", "<Leader>wj", "<C-w>j", "Move to the window below")
keymap("n", "<Leader>wk", "<C-w>k", "Move to the window above")
keymap("n", "<Leader>wh", "<C-w>h", "Move to the window to the left")
keymap("n", "<Leader>wl", "<C-w>l", "Move to the window to the right")
keymap("n", "<Leader>ww", "<C-w>w", "Move to the next window (below/right/top-left)")

-- moving window around
keymap("n", "<Leader>wJ", "<C-w>J", "Move the window to the bottom")
keymap("n", "<Leader>wK", "<C-w>K", "Move the window to the top")
keymap("n", "<Leader>wH", "<C-w>H", "Move the window to the left")
keymap("n", "<Leader>wL", "<C-w>L", "Move the window to the right")
keymap("n", "<Leader>wT", "<C-w>T", "Move the window to a new tab")
keymap("n", "<Leader>wx", "<C-w>x", "Exchange the current window with the next one/previous one")
keymap("n", "<Leader>wr", "<C-w>r", "Rotate windows downwards/clockwise/rightwards")
keymap("n", "<Leader>wR", "<C-w>R", "Rotate windows upwards/counterclockwise/leftwards")

-- new window
keymap("n", "<Leader>wn", "<C-w>n", "New empty in split window")
keymap("n", "<Leader>wN", "<Cmd>vnew<CR>", "New empty in vsplit window")

-- split window
keymap("n", "<Leader>ws", "<C-w>s", "Split window horizontally")
keymap("n", "<Leader>wv", "<C-w>v", "Split window vertically")

-- closing windows
keymap("n", "<Leader>wc", "<C-w>c", "Close the current window")
keymap("n", "<Leader>wo", "<C-w>o", "Close other windows")

-- window resizing
keymap("n", "<Leader>w=", "<C-w>=", "Make all windows equal size")
keymap("n", "<Leader>w-", "<C-w>-", "Decrease the height of the current window")
keymap("n", "<Leader>w+", "<C-w>+", "Increase the height of the current window")
keymap("n", "<Leader>w<", "<C-w><", "Decrease the width of the current window")
keymap("n", "<Leader>w>", "<C-w>>", "Increase the width of the current window")

-- buffer management
keymap("n", "<C-s>", require("kuuga.lib.save"), "Quick save")
keymap("n", "<Leader>e", "<Cmd>edit<CR>", "Quick re-edit")
keymap("n", "<Leader>qq", "<Cmd>quit<CR>", "Quick quit")
keymap("n", "<Leader>qa", "<Cmd>quitall<CR>", "Quick quit all")
keymap("n", "<Leader>fqq", "<Cmd>quit!<CR>", "Quick quit without writing")

-- terminal
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", "Exit terminal mode")

-- clipboard (copy/paste to system clipboard)
keymap({ "n", "v", "x" }, "<Leader>y", '"+y', "Yank into clipboard", { silent = true, noremap = true })
keymap({ "n", "v", "x" }, "<Leader>yy", '"+yy', "Yank lines into clipboard", { silent = true, noremap = true })
keymap(
	{ "n", "v", "x" },
	"<Leader>Y",
	'"+y$',
	"Yank lines into clipboard (from cursor position)",
	{ silent = true, noremap = true }
)
keymap({ "n", "v", "x" }, "<Leader>p", '"+p', "Paste from clipboard", { silent = true, noremap = true })
keymap("x", "<Leader>P", '"_dP', "Paste without erase unnamed register", { silent = true, noremap = true })
