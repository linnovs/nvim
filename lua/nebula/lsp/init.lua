local lsp_installer_servers = require("nvim-lsp-installer.servers")
local vimp = require("vimp")
local builtin = require("telescope.builtin")

local signs = { Error = "", Warn = "", Hint = "", Info = "" }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local on_attach = function(_, bufnr)
	-- enable completion
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	vimp.add_buffer_maps(bufnr, function()
		vimp.nnoremap({ "override" }, "gD", vim.lsp.buf.declaration)
		vimp.nnoremap({ "override" }, "gd", builtin.lsp_definitions)
		vimp.nnoremap({ "override" }, "gi", builtin.lsp_implementations)
		vimp.nnoremap({ "override" }, "K", vim.lsp.buf.hover)
		vimp.nnoremap({ "override" }, "<C-k>", vim.lsp.buf.signature_help)
		vimp.nnoremap({ "override" }, "<Leader>rn", vim.lsp.buf.rename)
		vimp.nnoremap({ "override" }, "<Leader>ca", ":CodeActionMenu<CR>")
		vimp.nnoremap({ "override" }, "<Leader>D", builtin.lsp_type_definitions)
		vimp.nnoremap({ "override" }, "gr", builtin.lsp_references)
		vimp.nnoremap({ "override" }, "<Leader>ds", builtin.lsp_document_symbols)
	end)

	require("lsp_signature").on_attach()
end

local servers = { "sumneko_lua", "yamlls", "rust_analyzer", "gdscript", "gopls", "jsonls", "null-ls" }

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
