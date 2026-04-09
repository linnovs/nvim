local gh = require("kuuga.helper.gh")
vim.schedule(
	function()
		vim.pack.add({
			gh("windwp/nvim-ts-autotag"),
			gh("JoosepAlviste/nvim-ts-context-commentstring"),
			gh("nvim-treesitter/nvim-treesitter"),
		})
	end
)
