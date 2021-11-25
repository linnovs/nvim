local null_ls = require("null-ls")

local sources = {
	null_ls.builtins.code_actions.gitsigns,
	null_ls.builtins.diagnostics.golangci_lint.with({
		args = { "run", "--fix=false", "--output-format=json", "$DIRNAME", "--path-prefix", "$ROOT" },
	}),
}

null_ls.config({
	sources = sources,
})
