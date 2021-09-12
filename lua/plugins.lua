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


	-- }}}

	-- Visual {{{

	-- colorscheme
	use({ "RRethy/nvim-base16" })

	-- }}}
end)
