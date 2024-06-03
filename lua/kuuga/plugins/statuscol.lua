return {
	"luukvbaal/statuscol.nvim",
	event = "VeryLazy",
	opts = function()
		local builtin = require("statuscol.builtin")

		return {
			segments = {
				{
					text = { "%s" },
					click = "v:lua.ScSa",
				},
				{
					text = { builtin.lnumfunc, " " },
					condition = { true, builtin.not_empty },
					click = "v:lua.ScLa",
				},
				{
					text = { builtin.foldfunc, " " },
					condition = { true, builtin.not_empty },
					click = "v:lua:ScFa",
				},
			},
		}
	end,
}
