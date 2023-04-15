local function map(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { desc = desc })
end

-- window management
map("n", "<Leader>ws", "<C-w>s", "Split window horizontally")
map("n", "<Leader>wv", "<C-w>v", "Split window vertically")
map("n", "<Leader>wn", "<C-w>n", "New empty file in a split")
map("n", "<Leader>wo", "<C-w>o", "Make the current window as the only one")
map("n", "<Leader>wj", "<C-w>j", "Move cursor to below window")
map("n", "<Leader>wk", "<C-w>k", "Move cursor to above window ")
map("n", "<Leader>wh", "<C-w>h", "Move cursor to left window")
map("n", "<Leader>wl", "<C-w>l", "Move cursor to right window")
map("n", "<Leader>wJ", "<C-w>J", "Move window to the very bottom")
map("n", "<Leader>wK", "<C-w>K", "Move window to the very top")
map("n", "<Leader>wH", "<C-w>H", "Move window to the far left")
map("n", "<Leader>wL", "<C-w>L", "Move window to the far right")
map("n", "<Leader>w=", "<C-w>=", "Make window equally high and wide (almost)")
map("n", "<Leader>w+", "<C-w>+", "Increase window height")
map("n", "<Leader>w-", "<C-w>-", "Decrease window height")
map("n", "<Leader>w<", "<C-w><", "Decrease window width")
map("n", "<Leader>w>", "<C-w>>", "Increase window width")
map("n", "<Leader>w|", "<C-w>|", "Make the window largest (not closing any)")
map("n", "<Leader>s", "<cmd>update<CR>", "Quick save")
map("n", "<Leader>qq", "<cmd>quit<CR>", "Quick quit")

map("n", "yoh", function()
	vim.opt.hlsearch = not vim.opt.hlsearch:get()
end, "Toggle highlight search")

map("n", "yos", function()
	vim.opt.spell = not vim.opt.spell:get()
end, "Toggle spell check")

map("n", "yoc", function()
	vim.opt.cursorcolumn = not vim.opt.cursorcolumn:get()
end, "Toggle cursor column")

map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", "Escape and clear hlsearch")
map("t", "<esc><esc>", "<C-\\><C-n>", "Enter normal mode")

map("n", "<Leader>lazy", "<CMD>Lazy<CR>", "Open Lazy.nvim")
