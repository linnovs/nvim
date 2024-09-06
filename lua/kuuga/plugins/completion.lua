local dependencies = {
	-- completion sources
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-calc",
	"saadparwaiz1/cmp_luasnip",
	"chrisgrieser/cmp-nerdfont",
	"petertriho/cmp-git",
	"Exafunction/codeium.nvim",

	-- other dependencies
	"onsails/lspkind.nvim",
}

return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = dependencies,
	version = false,
	opts = function()
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")
		local cmp = require("cmp")
		local defaults = require("cmp.config.default")()

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
			["<C-Space>"] = cmp.mapping({
				i = function()
					if cmp.visible() then
						cmp.close()
					else
						cmp.complete()
					end
				end,
			}),
			["<C-n>"] = cmp.mapping({ i = cmp.mapping.select_next_item(), c = cmp.mapping.select_next_item() }),
			["<C-p>"] = cmp.mapping({ i = cmp.mapping.select_prev_item(), c = cmp.mapping.select_prev_item() }),
			["<CR>"] = cmp.mapping({
				i = function(fallback)
					if cmp.visible() and cmp.get_active_entry() then
						cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
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

		return {
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
					symbol_map = require("kuuga.lib.icons").kinds,
					before = function(entry, vim_item)
						vim_item.menu = ({
							nvim_lsp = "[LSP]",
							luasnip = "[LuaSnip]",
							codeium = "[Codeium]",
							nvim_lua = "[Lua]",
							nvim_lsp_signature_help = "[Signature]",
							nerdfont = "[NerdFont]",
							path = "[Path]",
							buffer = "[Buffer]",
							calc = "[Calc]",
							cmp_git = "[Git]",
						})[entry.source.name]

						return vim_item
					end,
				}),
			},
			sorting = defaults.sorting,
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "codeium" },
				{ name = "path" },
				{ name = "calc" },
			}, {
				{ name = "nerdfont" },
				{ name = "buffer" },
			}),
		}
	end,
	config = function(_, opts)
		local cmp = require("cmp")

		cmp.setup(opts)

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({ { name = "buffer" } }),
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
			---@diagnostic disable-next-line: missing-fields
			matching = { disallow_symbol_nonprefix_matching = false },
		})

		cmp.setup.filetype({ "gitcommit", "NeogitCommitMessage" }, {
			sources = cmp.config.sources({
				{ name = "cmp_git" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "codeium" },
			}),
		})
	end,
}
