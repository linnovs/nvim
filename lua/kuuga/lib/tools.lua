local M = {}

M.formatters = {
	lua = { "stylua" },
	go = { "gofmt", "goimports", "golines" },
	zsh = { "beautysh" },
	bash = { "beautysh" },
	sh = { "beautysh" },
	javascript = { { "prettierd", "prettier" } },
	["*"] = { "trim_whitespace" },
}

M.linters = {}

M.debugger = {}

local pseudo_tools = {
	"gofmt", -- gofmt is from golang.org/x/tools/cmd/gofmt
	"trim_whitespace",
}

M.to_install = function()
	local formatters = vim.tbl_flatten(vim.tbl_values(M.formatters))
	local linters = vim.tbl_flatten(vim.tbl_values(M.linters))
	local tools = vim.list_extend(vim.fn.copy(formatters), linters)
	vim.list_extend(tools, M.debugger)

	table.sort(tools)
	tools = vim.fn.uniq(tools)

	tools = vim.tbl_filter(function(tool)
		return not vim.tbl_contains(pseudo_tools, tool)
	end, vim.fn.copy(tools))

	return tools
end

return M
