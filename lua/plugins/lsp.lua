local icons = require("kuuga.icons").kinds
local signs = require("kuuga.icons").diagnostics

return {
	{
		"neovim/nvim-lspconfig",
		version = false,
		event = "BufReadPre",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "neovim/nvim-lspconfig" } },
			"folke/neodev.nvim",
			"b0o/schemastore.nvim",
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
						settings = {
							ltex = {
								language = "en-US",
							},
						},
					},
					omnisharp = {},
					pylsp = {},
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
					tailwindcss = {},
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

			require("kuuga.config.lsp").setup({})
			require("neoconf").setup({})
			require("neodev").setup({})

			for _, server in ipairs(vim.tbl_keys(servers)) do
				local config = servers[server]
				config.capabilities = capabilities

				lspconfig[server].setup(config)
			end
		end,
	},

	{
		"williamboman/mason.nvim",
		config = true,
		build = ":MasonUpdate",
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
		opts = { use_diagnostic_signs = true },
		keys = {
			{
				"<leader>xx",
				"<CMD>TroubleToggle document_diagnostics<CR>",
				desc = "Toggle Trouble (Document diagnostics)",
			},
			{
				"<leader>xX",
				"<CMD>TroubleToggle workspace_diagnostics<CR>",
				desc = "Toggle Trouble (Workspace diagnostics)",
			},
		},
	},
}
