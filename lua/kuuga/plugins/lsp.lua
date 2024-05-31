local icons = require("kuuga.lib.icons").kinds
local signs = require("kuuga.lib.icons").diagnostics

return {
	{
		"neovim/nvim-lspconfig",
		event = "BufNew",
		version = false,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "neovim/nvim-lspconfig" } },
			{ "folke/neodev.nvim", opts = { library = { plugins = { "nvim-dap-ui" } }, types = true } },
			{ "b0o/schemastore.nvim", version = false },
		},
		init = function()
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			vim.diagnostic.config({
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})
		end,
		opts = function()
			local schemastore = require("schemastore")

			return {
				servers = {
					bashls = {},
					clangd = {
						filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
					},
					cmake = {},
					eslint = {
						settings = {
							packageManager = "yarn",
							format = false,
						},
					},
					dockerls = {},
					gdscript = {},
					golangci_lint_ls = {},
					gopls = {
						settings = {
							gopls = {
								hints = {
									assignVariableTypes = true,
									compositeLiteralFields = true,
									constantValues = true,
									functionTypeParameters = true,
									parameterNames = true,
									rangeVariableTypes = true,
								},
							},
						},
					},
					jsonls = {
						settings = {
							json = {
								schemas = schemastore.json.schemas(),
								validate = { enable = true },
							},
						},
					},
					ltex = {
						filetypes = {
							"bib",
							"gitcommit",
							"markdown",
							"org",
							"plaintex",
							"rst",
							"rnoweb",
							"tex",
							"pandoc",
							"quarto",
							"rmd",
							"NeogitCommitMessage",
						},
						settings = {
							ltex = {
								enabled = true,
								language = "en-US",
								checkFrequency = "save",
								additionalRules = {
									enablePickyRules = true,
									motherTongue = "zh-CN",
								},
							},
						},
						flags = { debounce_text_changes = 300 },
					},
					omnisharp = {},
					pbls = {},
					pyright = {
						settings = {
							pyright = {
								disableOrganizeImports = true, -- use ruff
							},
							python = {
								analysis = {
									ignore = { "*" }, -- use ruff
								},
							},
						},
					},
					rust_analyzer = {},
					lua_ls = {
						settings = {
							Lua = {
								hint = {
									enable = true,
								},
								format = {
									enable = false,
								},
								workspace = {
									checkThirdParty = false,
								},
								completion = {
									callSnippet = "Replace",
								},
							},
						},
					},
					nil_ls = {},
					terraformls = {},
					tsserver = {
						settings = {
							typescript = {
								inlayHints = {
									includeInlayParameterNameHints = "all",
									includeInlayParameterNameHintsWhenArgumentMatchesName = false,
									includeInlayFunctionParameterTypeHints = true,
									includeInlayVariableTypeHints = true,
									includeInlayVariableTypeHintsWhenTypeMatchesName = false,
									includeInlayPropertyDeclarationTypeHints = true,
									includeInlayFunctionLikeReturnTypeHints = true,
									includeInlayEnumMemberValueHints = true,
								},
							},
							javascript = {
								inlayHints = {
									includeInlayParameterNameHints = "all",
									includeInlayParameterNameHintsWhenArgumentMatchesName = false,
									includeInlayFunctionParameterTypeHints = true,
									includeInlayVariableTypeHints = true,
									includeInlayVariableTypeHintsWhenTypeMatchesName = false,
									includeInlayPropertyDeclarationTypeHints = true,
									includeInlayFunctionLikeReturnTypeHints = true,
									includeInlayEnumMemberValueHints = true,
								},
							},
						},
					},
					typos_lsp = {},
					volar = {},
					yamlls = {
						settings = {
							yaml = {
								schemaStore = {
									enable = false,
									url = "",
								},
								schemas = schemastore.yaml.schemas(),
							},
						},
					},
					zls = {},
				},
			}
		end,
		config = function(_, opts)
			local servers = opts.servers
			local lspconfig = require("lspconfig")
			local masonlsp = require("mason-lspconfig")
			local cmp_lsp = require("cmp_nvim_lsp")

			masonlsp.setup({ automatic_installation = true })

			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities(),
				{
					textDocument = {
						foldingRange = {
							dynamicRegistration = false,
							lineFoldingOnly = true,
						},
					},
				}
			)

			require("kuuga.lib.lsp").setup()
			require("neoconf").setup({})
			require("neodev").setup({})

			for _, server in ipairs(vim.tbl_keys(servers)) do
				local config = servers[server]
				config.capabilities = capabilities

				lspconfig[server].setup(config)
			end
		end,
	},

	-- code context
	{
		"SmiteshP/nvim-navic",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		lazy = true,
		opts = {
			icons = icons,
			highlight = true,
			safe_output = true,
		},
	},

	{
		"SmiteshP/nvim-navbuddy",
		lazy = true,
		dependencies = {
			"neovim/nvim-lspconfig",
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ "<leader>cc", "<CMD>Navbuddy<CR>", desc = "Navbuddy" },
		},
		opts = {
			window = {
				border = "rounded",
			},
			icons = icons,
		},
	},

	{
		"folke/trouble.nvim",
		cmd = { "Trouble", "TroubleToggle" },
		opts = {},
		keys = {
			{
				"<leader>xx",
				"<CMD>Trouble diagnostics toggle filter.buf=0<CR>",
				desc = "Toggle Trouble (buffer diagnostics)",
			},
			{
				"<leader>xX",
				"<CMD>Trouble diagnostics toggle<CR>",
				desc = "Toggle Trouble (Workspace diagnostics)",
			},
		},
	},
}
