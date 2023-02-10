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
			{ "ray-x/lsp_signature.nvim", version = false },
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
				clangd = {},
				cmake = {},
				eslint = {
					format = false,
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
			require("mason-lspconfig").setup({ automatic_installation = true })

			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			for _, server in ipairs(vim.tbl_keys(servers)) do
				local config = servers[server]
				config.on_attach = lsp.on_attach
				config.capabilities = capabilities
				if config.disable_format == true then
					config.disable_format = nil
					lsp.disable_format(server)
				end

				if config.disable_diagnostic ~= nil then
					lsp.disable_diagnostic(server, config.disable_diagnostic)
					config.disable_diagnostic = nil
				end

				require("lspconfig")[server].setup(config)
			end
		end,
	},

	{
		"williamboman/mason.nvim",
		config = true,
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		dependencies = { "williamboman/mason.nvim" },
		opts = function()
			local null_ls = require("null-ls")

			return {
				on_attach = lsp.on_attach,
				diagnostic_format = "[#{c}] #{m}",
				sources = {
					null_ls.builtins.code_actions.gitsigns,
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
