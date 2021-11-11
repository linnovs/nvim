require("lint").linters_by_ft = {
	go = { "golangcilint" },
}

require("nebula.nvim_augroup").creates({
	lint = {
		{ "BufWritePost", "*.go", "lua require('lint').try_lint()" },
	},
})
