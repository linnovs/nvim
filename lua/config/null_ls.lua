local on_attach = require("config.lsp.on_attach")
local null_ls = require("null-ls")

local sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.diagnostics.golangci_lint.with({
        args = { "run", "--fix=false", "--out-format=json", "$DIRNAME", "--path-prefix", "$ROOT" },
    }),
    null_ls.builtins.diagnostics.proselint.with({
        filetypes = { "*" },
    }),
    null_ls.builtins.diagnostics.write_good.with({
        filetypes = { "*" },
    }),
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.taplo,
    null_ls.builtins.formatting.trim_whitespace,
    null_ls.builtins.formatting.trim_newlines,
}

null_ls.setup({
    on_attach = on_attach,
    diagnostic_format = "[#{c}] #{m}",
    sources = sources,
})
