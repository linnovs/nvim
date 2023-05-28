local dependencies = {
	-- completion sources
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-nvim-lua",
	"saadparwaiz1/cmp_luasnip",
	"f3fora/cmp-spell",
	{
		"zbirenbaum/copilot-cmp",
		dependencies = {
			"zbirenbaum/copilot.lua",
		},
		config = true,
	},
	{
		"petertriho/cmp-git",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = true,
	},

	"petertriho/cmp-git",
	"davidsierradz/cmp-conventionalcommits",
	"jcdickinson/codeium.nvim",

	-- other dependencies
	"onsails/lspkind.nvim",
}

return {
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = dependencies,
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
							cmp.confirm({ select = false })
						else
							fallback()
						end
					end,
					s = cmp.mapping.confirm({ select = true }),
					c = cmp.mapping.confirm({ select = false }),
				}),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-b>"] = cmp.mapping({ i = cmp.mapping.scroll_docs(-4) }),
				["<C-f>"] = cmp.mapping({ i = cmp.mapping.scroll_docs(4) }),
			}

			cmp.setup({
				experimental = {
					ghost_text = true,
				},
				preselect = cmp.PreselectMode.None,
				window = {
					completion = {
						col_offset = -2,
						side_padding = 0,
					},
					documentation = {
						border = "rounded",
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
				-- sorting = {
				--     priority_weight = 2,
				--     comparators = {
				--         cmp.config.compare.offset,
				--         cmp.config.compare.exact,
				--         cmp.config.compare.score,
				--         cmp.config.compare.kind,
				--         cmp.config.compare.sort_text,
				--         cmp.config.compare.length,
				--         cmp.config.compare.order,
				--     },
				-- },
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
