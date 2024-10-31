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
	sh = { "beautysh" },
	zsh = { "beautysh" },
}

M.linters = {
	python = { "ruff" },
	proto = { "protolint" },
}

M.debugger = {
	"delve",
}

local pseudo_tools = {
	"gofmt", -- gofmt is from golang.org/x/tools/cmd/gofmt
	"trim_whitespace",
	"nixpkgs_fmt", -- nixpkgs_fmt is for Conform.nvim to active configuration only
}

local mason_names = {
	ruff_fix = "ruff",
	ruff_format = "ruff",
}

M.to_install = function()
	local formatters = vim.iter(vim.tbl_values(M.formatters)):flatten(2):totable()
	local linters = vim.iter(vim.tbl_values(M.linters)):flatten(2):totable()
	local tools = vim.list_extend(vim.fn.copy(formatters), linters)
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
