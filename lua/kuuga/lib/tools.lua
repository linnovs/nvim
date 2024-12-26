local M = {}

---@module 'conform'
---@type table<string, conform.FiletypeFormatter>
M.formatters = {
	["*"] = { "trim_whitespace" },
	bash = { "beautysh" },
	go = { "goimports", "golines", "gofumpt" },
	javascript = { "prettierd" },
	lua = { "stylua" },
	markdown = { "prettierd" },
	nix = { "nixpkgs_fmt" },
	proto = { "protolint" },
	python = { "ruff_fix", "ruff_format" },
	rust = { "rustfmt" },
	sh = { "beautysh" },
	yaml = { "prettierd" },
	zsh = { "beautysh" },
}

M.linters = {
	["*"] = {}, -- this need to add a `try_lint(linter)` at the end of the autocmd
	rust = { "clippy" },
	python = { "ruff" },
	proto = { "protolint" },
	ghaction = { "actionlint" },
}

M.mason_installs = {
	"actionlint",
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
