return {
	{
		"numToStr/Comment.nvim",
		event = "BufReadPost",
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},

	{
		"kylechui/nvim-surround",
		event = "BufReadPost",
		version = false,
		config = true,
	},

	{
		"windwp/nvim-autopairs",
		event = "BufReadPost",
		config = true,
	},

	-- copilot
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
		opts = function()
			return {
				formatters = {
					insert_text = require("copilot_cmp.format").remove_existing,
				},
			}
		end,
	},

	-- codeium
	{
		"jcdickinson/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		lazy = true,
		opts = {},
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
		opts = {},
	},

	-- cmp-git
	{
		"petertriho/cmp-git",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		lazy = true,
		opts = {},
	},

	-- completion
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			-- completion sources
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"saadparwaiz1/cmp_luasnip",
			"f3fora/cmp-spell",
			"zbirenbaum/copilot-cmp",
			"petertriho/cmp-git",
			"davidsierradz/cmp-conventionalcommits",
			"jcdickinson/codeium.nvim",

			-- other dependencies
			"onsails/lspkind.nvim",
		},
		config = function()
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")
			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")

			local mapping = {
				["<Tab>"] = cmp.mapping({
					i = function(fallback)
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end,
				}),
				["<S-Tab>"] = cmp.mapping({
					i = function(fallback)
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end,
				}),
				["<C-Space>"] = cmp.mapping({ i = cmp.mapping.complete() }),
				["<C-S-P>"] = cmp.mapping({ i = cmp.mapping.complete() }),
				["<C-n>"] = cmp.mapping({ i = cmp.mapping.select_next_item(), c = cmp.mapping.select_next_item() }),
				["<C-p>"] = cmp.mapping({ i = cmp.mapping.select_prev_item(), c = cmp.mapping.select_prev_item() }),
				["<CR>"] = cmp.mapping({
					i = function(fallback)
						if cmp.visible() and cmp.get_active_entry() then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
						else
							fallback()
						end
					end,
					s = cmp.mapping.confirm({ select = true }),
					c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
				}),
				["<C-b>"] = cmp.mapping({ i = cmp.mapping.scroll_docs(-4) }),
				["<C-f>"] = cmp.mapping({ i = cmp.mapping.scroll_docs(4) }),
			}

			cmp.setup({
				completion = {
					completeopt = table.concat(vim.opt.completeopt:get(), ","),
				},
				window = {
					completion = {
						col_offset = -2,
						side_padding = 0,
					},
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = mapping,
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = lspkind.cmp_format({
						mode = "symbol",
						maxwidth = 50,
						symbol_map = require("kuuga.icons").kinds,
						before = function(entry, vim_item)
							vim_item.menu = ({
								buffer = "[Buffer]",
								cmp_git = "[Git]",
								conventionalcommits = "[Conventional Commits]",
								copilot = "[Copilot]",
								codeium = "[Codeium]",
								luasnip = "[LuaSnip]",
								nvim_lsp = "[LSP]",
								nvim_lua = "[Lua]",
								path = "[Path]",
								spell = "[Spell]",
							})[entry.source.name]

							return vim_item
						end,
					}),
				},
				sources = cmp.config.sources({
					{ name = "copilot" },
					{ name = "codeium" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "nvim_lua" },
				}, {
					{ name = "spell" },
					{ name = "path" },
					{ name = "buffer" },
				}),
			})

			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
			cmp.setup.cmdline({ "/", "?" }, {
				sources = cmp.config.sources({ { name = "buffer" } }),
			})
			cmp.setup.cmdline(":", {
				sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
			})
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "conventionalcommits" },
					{ name = "cmp_git" },
				}, {
					{ name = "buffer" },
					{ name = "spell" },
				}),
			})
		end,
	},
}
