local gh = require("kuuga.helper.gh")
local keymap = require("kuuga.lib.keymap")

vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		vim.pack.add({ { src = gh("folke/todo-comments.nvim"), version = vim.version.range("*") } })

		require("todo-comments").setup()

		keymap("n", "<Leader>ft", function() Snacks.picker.todo_comments() end, "Find TODOs")
		keymap("n", "]t", function() require("todo-comments").jump_next() end, "Next TODO comment")
		keymap("n", "[t", function() require("todo-comments").jump_prev() end, "Prev TODO comment")
	end,
})
