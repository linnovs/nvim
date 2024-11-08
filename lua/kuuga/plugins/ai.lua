vim.g.codeium_disable_bindings = 1
vim.g.codeium_manual = true

return {
	"Exafunction/codeium.vim",
	branch = "main",
	event = "VeryLazy",
	config = function()
		local map = require("kuuga.lib.keymap").map

		map("i", "<Tab>", function()
			return vim.fn["codeium#Accept"]()
		end, "Accept codeium suggestion", { silent = true, expr = true })

		map("i", "<C-x>", function()
			return vim.fn["codeium#Clear"]()
		end, "Clear codeium suggestion")

		map("i", "<C-n>", function()
			return vim.fn["codeium#CycleOrComplete"]()
		end, "Next codeium suggestion")

		map("i", "<C-p>", function()
			return vim.fn["codeium#CycleCompletions"](-1)
		end, "Previous codeium suggestion")
	end,
}
