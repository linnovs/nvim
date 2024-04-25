return {
	"L3MON4D3/LuaSnip",
	dependencies = {
		{
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
	},
	build = "make install_jsregexp",
	lazy = true,
	opts = {
		history = true,
		delete_check_events = "TextChanged",
	},
}
