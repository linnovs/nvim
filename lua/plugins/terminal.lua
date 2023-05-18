return {
	{
		"numtostr/FTerm.nvim",
		event = "VeryLazy",
		config = function()
			local fterm = require("FTerm")

			fterm.setup({
				border = "single",
			})

			local lg = fterm:new({
				cmd = "lazygit",
			})

			vim.keymap.set({ "n", "t" }, "<Leader>tt", fterm.toggle, { desc = "Toggle Terminal" })
			vim.keymap.set("n", "<Leader>gst", function()
				lg:toggle()
			end, { desc = "Toggle lazygit" })
		end,
	},
}
