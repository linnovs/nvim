local M = {}

M.formatters = {
	lua = { "stylua" },
	go = { "goimports", "golines", "gofumpt" },
	zsh = { "beautysh" },
	bash = { "beautysh" },
	sh = { "beautysh" },
	nix = { "nixpkgs_fmt", "nixpkgs-fmt" },
	javascript = { { "prettierd", "prettier" } },
	python = { "ruff_fix", "ruff_format" },
	proto = { "buf" },
	["*"] = { "trim_whitespace" },
}

M.linters = {
	python = { "ruff" },
	proto = { "buf_lint" },
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
	buf_lint = "buf",
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
