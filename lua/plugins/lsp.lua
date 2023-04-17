local icons = require("kuuga.icons").kinds
local signs = require("kuuga.icons").diagnostics
local lsp = require("kuuga.config.lsp")

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

return {
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"weilbith/nvim-code-action-menu",
		},
		init = function()
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end
		end,
		opts = {
			servers = {
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
				gdscript = {},
				gopls = {},
				jsonls = {},
				ltex = {
					settings = {
						ltex = {
							checkFrequency = "save",
							additionalRules = {
								motherTongue = "zh-CN",
							},
						},
					},
				},
				omnisharp = {},
				pylsp = {},
				rust_analyzer = {},
				sumneko_lua = {
					settings = {
						Lua = {
							runtime = {
								-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
								version = "LuaJIT",
								-- Setup your lua path
								path = runtime_path,
							},
							diagnostics = {
								-- Get the language server to recognize the `vim` global
								globals = { "vim" },
							},
							-- Do not send telemetry data containing a randomized but unique identifier
							telemetry = {
								enable = false,
							},
						},
					},
					disable_format = true,
				},
				tailwindcss = {},
				terraformls = {},
				-- tsserver = {
				-- 	disable_format = true,
				-- },
				volar = {
					filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
					disable_format = true,
				},
				yamlls = {
					settings = {
						yaml = {
							schemaStore = {
								enable = true,
							},
						},
					},
					disable_diagnostic = { "helm" },
				},
			},
		},
		config = function(_, opts)
			local servers = opts.servers
			local lspconfig = require("lspconfig")
			local masonlsp = require("mason-lspconfig")
			local cmp_lsp = require("cmp_nvim_lsp")
			local lsp_lines = require("lsp_lines")

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

			for _, server in ipairs(vim.tbl_keys(servers)) do
				local config = servers[server]
				config.capabilities = capabilities

				if config.disable_format == true then
					lsp.disable_format(server)
				end

				if config.disable_diagnostic ~= nil then
					lsp.disable_diagnostic(server, config.disable_diagnostic)
				end

				lspconfig[server].setup(config)
			end

			lsp_lines.setup({})
		end,
	},

	{
		"williamboman/mason.nvim",
		config = true,
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

	{
		"lvimuser/lsp-inlayhints.nvim",
		lazy = true,
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		opts = {},
	},

	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		version = false,
		lazy = true,
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		init = function()
			vim.diagnostic.config({
				virtual_text = false,
				virtual_lines = { only_current_line = true },
			})
		end,
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		dependencies = { "williamboman/mason.nvim", "nvim-lua/plenary.nvim" },
		opts = function()
			local null_ls = require("null-ls")

			return {
				on_attach = lsp.on_attach,
				diagnostic_format = "[#{c}] #{m}",
				sources = {
					null_ls.builtins.code_actions.gitsigns,
					null_ls.builtins.code_actions.ltrs,
					null_ls.builtins.diagnostics.ltrs,
					null_ls.builtins.diagnostics.golangci_lint.with({
						args = { "run", "--fix=false", "--out-format=json", "$DIRNAME", "--path-prefix", "$ROOT" },
					}),
					null_ls.builtins.formatting.gofmt,
					null_ls.builtins.formatting.goimports,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.rustfmt,
					null_ls.builtins.formatting.terraform_fmt,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.taplo,
					null_ls.builtins.formatting.trim_whitespace,
					null_ls.builtins.formatting.trim_newlines,
				},
			}
		end,
	},
}
