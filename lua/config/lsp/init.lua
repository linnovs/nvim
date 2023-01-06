local on_attach = require("config.lsp.on_attach")

local signs = { Error = "", Warn = "", Hint = "", Info = "" }

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local servers = {
    "clangd",
    "cmake",
    "gdscript",
    "gopls",
    "jsonls",
    "ltex",
    "omnisharp",
    "pylsp",
    "rust_analyzer",
    "sumneko_lua",
    "terraformls",
    "yamlls",
}

require("config.null_ls")

require("nvim-lsp-installer").setup({
    automatic_installation = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

for _, lsp in ipairs(servers) do
    local mod = "config.lsp." .. lsp
    local config = require(mod)
    config.on_attach = on_attach
    config.flags = { debounce_text_changes = 150 }
    config.capabilities = capabilities

    require("lspconfig")[lsp].setup(config)
end
