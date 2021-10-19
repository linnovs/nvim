-- vim: foldmethod=marker

return require("packer").startup({
	function(use)
		-- Packer manage itself
		use({ "wbthomason/packer.nvim" })

		-- Utility {{{

		-- startup time
		use({ "tweekmonster/startuptime.vim", cmd = "StartupTime" })

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
			config = function()
				require("nebula.plugin.autopairs")
			end,
		})

		use("editorconfig/editorconfig-vim")

		use({
			"numtostr/FTerm.nvim",
			config = function()
				require("nebula.plugin.terminal")
			end,
		})

		-- coding time logging
		use({ "wakatime/vim-wakatime" })

		-- }}}

		-- Visual {{{

		-- indent-guideline
		use({
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("nebula.plugin.indent-guideline")
			end,
		})

		-- todo-comment
		use({
			"folke/todo-comments.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("nebula.plugin.todo-comments")
			end,
		})

		-- color highlighter
		use({
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("colorizer").setup()
			end,
		})

		-- }}}

		-- UI {{{

		-- tokyo night colorscheme
		use("folke/tokyonight.nvim")

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
			requires = { "kyazdani42/nvim-web-devicons" },
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

		-- which-key
		use({
			"folke/which-key.nvim",
			config = function()
				require("nebula.plugin.which-key")
			end,
		})

		-- }}}

		-- Syntax {{{

		-- treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			run = "TSUpdate",
			config = function()
				require("nebula.plugin.treesitter")
			end,
		})

		use({
			"lewis6991/spellsitter.nvim",
			config = function()
				require("nebula.plugin.spellsitter")
			end,
		})

		use({
			"SmiteshP/nvim-gps",
			requires = { "nvim-treesitter/nvim-treesitter" },
			config = function()
				require("nebula.plugin.nvim-gps")
			end,
		})

		use({ "nvim-treesitter/playground", requires = { "nvim-treesitter/nvim-treesitter" } })

		use({ "alker0/chezmoi.vim" })

		-- }}}

		-- LSP {{{

		-- native LSP configuration
		use({
			"neovim/nvim-lspconfig",
			config = function()
				require("nebula.lsp")
			end,
			requires = { "williamboman/nvim-lsp-installer", "ray-x/lsp_signature.nvim" },
		})

		-- lsputil
		use({
			"RishabhRD/nvim-lsputils",
			requires = { "RishabhRD/popfix" },
		})

		-- codeAction
		use({ "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" })

		-- trouble
		use({
			"folke/trouble.nvim",
			config = function()
				require("nebula.plugin.trouble")
			end,
		})

		use({
			"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/cmp-nvim-lsp", -- lsp source
				"hrsh7th/cmp-buffer", -- buffer source
				"L3MON4D3/LuaSnip", -- snippet engine
				"saadparwaiz1/cmp_luasnip", -- snippet source
				"hrsh7th/cmp-path", -- path source
				"hrsh7th/cmp-nvim-lua", -- nvim-lua source
				"onsails/lspkind-nvim", -- vscode-like pictograms
			},
			config = function()
				require("nebula.plugin.completion")
				require("nebula.plugin.lspkind")
			end,
		})

		-- }}}

		-- Tool {{{

		-- markdown preview
		use({ "davidgranstrom/nvim-markdown-preview", cmd = { "MarkdownPreview" } })

		-- telescope fuzzy finder
		use({
			"nvim-telescope/telescope.nvim",
			config = function()
				require("nebula.plugin.telescope")
			end,
			requires = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons",
			},
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
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})
