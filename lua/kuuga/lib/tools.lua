local M = {}

M.formatters = {
	["*"] = { "trim_whitespace" },
	bash = { "beautysh" },
	go = { "goimports", "golines", "gofumpt" },
	javascript = { { "prettierd", "prettier" } },
	lua = { "stylua" },
	nix = { "nixpkgs_fmt", "nixpkgs-fmt" },
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

M.debugger = {
	"delve",
}

local pseudo_tools = {
	"gofmt", -- gofmt is from golang.org/x/tools/cmd/gofmt
	"trim_whitespace",
	"clippy", -- come with cargo (rust)
	"nixpkgs_fmt", -- nixpkgs_fmt is for Conform.nvim to active configuration only
}

local mason_names = {
	ruff_fix = "ruff",
	ruff_format = "ruff",
}

local extra_tools = {
	"cspell",
}

M.to_install = function()
	local tools = vim.fn.copy(extra_tools)

	local formatters = vim.iter(vim.tbl_values(M.formatters)):flatten(2):totable()
	local linters = vim.iter(vim.tbl_values(M.linters)):flatten(2):totable()

	vim.list_extend(tools, formatters)
	vim.list_extend(tools, linters)
	vim.list_extend(tools, M.debugger)

	tools = vim.tbl_map(function(tool)
		if mason_names[tool] then
			return mason_names[tool]
		end

		return tool
	end, vim.fn.copy(tools))

	table.sort(tools)
	tools = vim.fn.uniq(tools)

	tools = vim.tbl_filter(function(tool)
		return not vim.tbl_contains(pseudo_tools, tool)
	end, vim.fn.copy(tools))

	return tools
end

return M
