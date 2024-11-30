local M = {}

M.formatters = {
	["*"] = { "trim_whitespace" },
	bash = { "beautysh" },
	go = { "goimports", "golines", "gofumpt" },
	javascript = { "prettierd" },
	lua = { "stylua" },
	nix = { "nixpkgs_fmt" },
	proto = { "protolint" },
	python = { "ruff_fix", "ruff_format" },
	rust = { "rustfmt" },
	sh = { "beautysh" },
	zsh = { "beautysh" },
}

M.linters = {
	["*"] = {}, -- this need to add a `try_lint(linter)` at the end of the autocmd
	rust = { "clippy" },
	python = { "ruff" },
	proto = { "protolint" },
}

M.mason_installs = {
	"beautysh",
	"cspell",
	"gofumpt",
	"goimports",
	"golines",
	"nixpkgs-fmt",
	"prettierd",
	"protolint",
	"ruff",
	"stylua",
}

return M
