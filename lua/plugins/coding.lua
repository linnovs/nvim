return {
	{ "numToStr/Comment.nvim", opts = {}, event = "VeryLazy" },

	{
		"kylechui/nvim-surround",
		event = "BufReadPost",
		version = false,
		config = true,
	},

	{
		"windwp/nvim-autopairs",
		event = "VeryLazy",
		config = true,
	},

	{ "alker0/chezmoi.vim", event = "VeryLazy" }, -- syntax highlight for chezmoi
	{ "towolf/vim-helm", event = "VeryLazy" }, -- syntax highlight for helm

	{
		"zbirenbaum/copilot.lua",
		dependencies = { "nvim-lualine/lualine.nvim" },
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
		},
		config = function(_, opts)
			vim.defer_fn(function()
				vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
				require("copilot").setup(opts)
			end, 100)
		end,
	},

	{
		"zbirenbaum/copilot-cmp",
		dependencies = {
			"zbirenbaum/copilot.lua",
		},
		lazy = true,
		config = true,
	},

	-- snippet
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		lazy = true,
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
	},

	-- completion
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"zbirenbaum/copilot-cmp",
			"saadparwaiz1/cmp_luasnip",
			"f3fora/cmp-spell",
			"onsails/lspkind-nvim",
			"L3MON4D3/LuaSnip",
		},
		opts = function()
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")
			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")

			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({ { name = "buffer" } }),
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
			})

			return {
				view = { entries = { name = "custom", selection_order = "near_cursor" } },
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping(function(fallback)
						if require("luasnip").expand_or_locally_jumpable() then
							require("luasnip").expand_or_jump()
						else
							fallback()
						end
					end),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if require("luasnip").jumpable(-1) then
							require("luasnip").jump(-1)
						else
							fallback()
						end
					end),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-S-P>"] = cmp.mapping.complete(),
					["<C-y>"] = cmp.config.disable,
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					}),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol",
						maxwidth = 50,
						symbol_map = require("kuuga.icons").kinds,

						before = function(entry, vim_item)
							vim_item.menu = ({
								nvim_lsp = "[LSP]",
								luasnip = "[LuaSnip]",
								buffer = "[Buffer]",
								path = "[Path]",
								spell = "[Spell]",
								nvim_lua = "[Lua]",
								copilot = "[Copilot]",
							})[entry.source.name]

							return vim_item
						end,
					}),
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "copilot" },
					{ name = "luasnip" },
					{ name = "spell" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "nvim_lua" },
				}),
			}
		end,
	},
}
