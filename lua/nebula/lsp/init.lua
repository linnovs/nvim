local lsp_installer_servers = require("nvim-lsp-installer.servers")
local vimp = require("vimp")

local signs = { Error = "", Warn = "", Hint = "", Info = "" }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.lsp.handlers["textDocument/codeAction"] = require("lsputil.codeAction").code_action_handler
vim.lsp.handlers["textDocument/references"] = require("lsputil.locations").references_handler
vim.lsp.handlers["textDocument/definition"] = require("lsputil.locations").definition_handler
vim.lsp.handlers["textDocument/declaration"] = require("lsputil.locations").declaration_handler
vim.lsp.handlers["textDocument/typeDefinition"] = require("lsputil.locations").typeDefinition_handler
vim.lsp.handlers["textDocument/implementation"] = require("lsputil.locations").implementation_handler
vim.lsp.handlers["textDocument/documentSymbol"] = require("lsputil.symbols").document_handler
vim.lsp.handlers["workspace/symbol"] = require("lsputil.symbols").workspace_handler

local on_attach = function(_, bufnr)
	-- enable completion
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	vimp.add_buffer_maps(bufnr, function()
		vimp.nnoremap({ "override" }, "gD", function()
			vim.lsp.buf.declaration()
		end)
		vimp.nnoremap({ "override" }, "gd", function()
			vim.lsp.buf.definition()
		end)
		vimp.nnoremap({ "override" }, "K", function()
			vim.lsp.buf.hover()
		end)
		vimp.nnoremap({ "override" }, "<C-k>", function()
			vim.lsp.buf.signature_help()
		end)
		vimp.nnoremap({ "override" }, "<Leader>rn", function()
			vim.lsp.buf.rename()
		end)
		vimp.nnoremap({ "override" }, "<Leader>ca", ":CodeActionMenu<CR>")
		vimp.nnoremap({ "override" }, "<Leader>D", function()
			vim.lsp.buf.type_definition()
		end)
		vimp.nnoremap({ "override" }, "gr", function()
			vim.lsp.buf.references()
		end)
		vimp.nnoremap({ "override" }, "<Leader>ds", function()
			vim.lsp.buf.document_symbol()
		end)
	end)

	require("lsp_signature").on_attach()
end

local servers = { "sumneko_lua", "yamlls", "rust_analyzer", "gdscript" }

for _, lsp in ipairs(servers) do
	local mod = "nebula.lsp." .. lsp
	local config = require(mod)
	config.on_attach = on_attach
	config.flags = { debounce_text_changes = 150 }

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	config.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

	local ok, server = lsp_installer_servers.get_server(lsp)
	if ok then
		if not server:is_installed() then
			server:install()
		end

		server:setup(config)
	else
		require("lspconfig")[lsp].setup(config)
	end
end
