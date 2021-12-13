local vimp = require("vimp")
local builtin = require("telescope.builtin")

return function(_, bufnr)
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
