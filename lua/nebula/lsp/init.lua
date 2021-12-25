local lsp_installer_servers = require("nvim-lsp-installer.servers")
local on_attach = require("nebula.lsp.on_attach")

local signs = { Error = "", Warn = "", Hint = "", Info = "" }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local servers = { "sumneko_lua", "yamlls", "rust_analyzer", "gdscript", "gopls", "jsonls", "omnisharp" }

require("nebula.plugin.lint")

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
