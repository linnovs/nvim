return {
	{
		"numtostr/FTerm.nvim",
		keys = function()
			local fterm = require("FTerm")
			local lg = fterm:new({
				cmd = "lazygit",
			})

			return {
				{
					"<Leader>tt",
					fterm.toggle,
					desc = "Toggle Terminal (create new if not found)",
					mode = { "n", "t" },
				},
				{
					"<Leader>gst",
					function()
						lg:toggle()
					end,
					desc = "Toggle lazygit",
				},
			}
		end,
		config = function()
			local fterm = require("FTerm")

			fterm.setup({
				border = "single",
			})
		end,
	},
}
