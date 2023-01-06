local vimp = require("vimp")
local builtin = require("telescope.builtin")

return function(client, bufnr)
    -- enable completion
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    vimp.add_buffer_maps(bufnr, function()
        vimp.nnoremap({ "override" }, "gD", vim.lsp.buf.declaration)
        vimp.nnoremap({ "override" }, "gd", builtin.lsp_definitions)
        vimp.nnoremap({ "override" }, "gi", builtin.lsp_implementations)
        vimp.nnoremap({ "override" }, "K", vim.lsp.buf.hover)
        vimp.nnoremap({ "override" }, "<C-k>", vim.lsp.buf.signature_help)
        vimp.nnoremap({ "override" }, "<Leader>rn", vim.lsp.buf.rename)
        vimp.nnoremap({ "override" }, "<Leader>cam", ":CodeActionMenu<CR>")
        vimp.nnoremap({ "override" }, "<Leader>D", builtin.lsp_type_definitions)
        vimp.nnoremap({ "override" }, "gr", builtin.lsp_references)
        vimp.nnoremap({ "override" }, "<Leader>ds", builtin.lsp_document_symbols)
    end)

    if client.server_capabilities.documentFormattingProvider then
        vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
            augroup END
        ]])
    end

    if client.server_capabilities.codeLensProvider then
        vim.cmd([[
            augroup LspCodeLens
                autocmd! * <buffer>
                autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
            augroup END
        ]])
        vimp.add_buffer_maps(bufnr, function()
            vimp.nnoremap({ "override" }, "<Leader>cl", vim.lsp.codelens.run)
        end)
    end

    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
    end

    require("virtualtypes").on_attach()
    require("lsp_signature").on_attach()
end
