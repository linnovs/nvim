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

	-- indent-guideline
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("nebula.plugin.indent-guideline")
		end,
	})

	-- git
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("nebula.plugin.gitsign")
		end,
	})

	-- tabline
	use({
		"akinsho/bufferline.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("nebula.plugin.bufferline")
		end,
	})

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

	use({
		"lewis6991/spellsitter.nvim",
		config = function()
			require("nebula.plugin.spellsitter")
		end,
	})

	-- github integration
	use({
		"pwntester/octo.nvim",
		cmd = { "Octo" },
		config = function()
			require("nebula.plugin.github")
		end,
	})

	-- formatter
	use({
		"lukas-reineke/format.nvim",
		config = function()
			require("nebula.plugin.format")
		end,
	})

	-- }}}
end)
