local signs = require("kuuga.icons").diagnostics
local on_attach = require("kuuga.config.lsp").on_attach

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
				},
				tailwindcss = {},
				terraformls = {},
				tsserver = {},
				volar = {
					filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
				},
				yamlls = {},
			},
		},
		config = function(_, opts)
			local servers = opts.servers
			require("mason-lspconfig").setup({ automatic_installation = true })

			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			for _, lsp in ipairs(vim.tbl_keys(servers)) do
				local config = servers[lsp]
				config.on_attach = on_attach
				config.capabilities = capabilities

				require("lspconfig")[lsp].setup(config)
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
				on_attach = on_attach,
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
