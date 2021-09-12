-- vim: foldmethod=marker

return require("packer").startup(function(use)
	-- Packer manage itself
	use({ "wbthomason/packer.nvim" })

	-- Utility {{{

	-- better mapping handling
	use({ "svermeulen/vimpeccable" })

	-- commenting
	use({ "b3nj5m1n/kommentary" })

	use({
		"blackCauldron7/surround.nvim",
		config = function()
			require("surround").setup({ mappings_style = "surround" })
		end,
	})

	use({
		"windwp/nvim-autopairs",
		requires = {},
		config = function()
			require("nebula.plugin.autopairs")
		end,
	})

	-- coding time logging
	use({ "wakatime/vim-wakatime" })

	-- }}}

	-- Visual {{{

	-- colorscheme
	use({ "RRethy/nvim-base16" })

	-- statusline
	use({
		"famiu/feline.nvim",
		requires = { "kyazdani42/nvim-web-devicons", "SmiteshP/nvim-gps" },
		config = function()
			require("nebula.plugin.statusline")
		end,
	})

	-- file explorer
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("nebula.plugin.explorer")
		end,
	})

	-- }}}
end)
