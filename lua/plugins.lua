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

		use({ "tpope/vim-surround" })

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

		-- notification
		use({
			"rcarriga/nvim-notify",
			config = function()
				require("nebula.plugin.notify")
			end,
		})

		-- }}}

		-- UI {{{

		-- tokyo night colorscheme
		use("folke/tokyonight.nvim")

		-- dashboard
		use({
			"goolord/alpha-nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("nebula.plugin.dashboard")
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
		--[[ use({
			"famiu/feline.nvim",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = function()
				require("nebula.plugin.statusline.feline")
			end,
		}) ]]
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = function()
				require("nebula.plugin.statusline.lualine")
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
			run = ":TSUpdate",
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

		-- codeAction
		use({ "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" })

		-- trouble
		use({
			"folke/trouble.nvim",
			config = function()
				require("nebula.plugin.trouble")
			end,
		})

		-- completion
		use({
			"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/cmp-nvim-lsp", -- lsp source
				"hrsh7th/cmp-buffer", -- buffer source
				"L3MON4D3/LuaSnip", -- snippet engine
				"saadparwaiz1/cmp_luasnip", -- snippet source
				"hrsh7th/cmp-path", -- path source
				"f3fora/cmp-spell", -- spell source
				"hrsh7th/cmp-nvim-lua", -- nvim-lua source
				"onsails/lspkind-nvim", -- vscode-like pictograms
				"petertriho/cmp-git", -- git related source
			},
			config = function()
				require("nebula.plugin.completion")
				require("nebula.plugin.lspkind")
			end,
		})

		-- lint
		use({
			"jose-elias-alvarez/null-ls.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"neovim/nvim-lspconfig",
			},
		})

		-- virtual type
		use({
			"jubnzv/virtual-types.nvim",
			requires = {
				"neovim/nvim-lspconfig",
			},
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
				"jvgrootveld/telescope-zoxide",
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

		-- zen mode
		use({
			"folke/zen-mode.nvim",
			config = function()
				require("nebula.plugin.zen")
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
