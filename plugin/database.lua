vim.g.db_ui_use_nerd_fonts = 1

local function packadd()
	vim.pack.add({
		"https://github.com/tpope/vim-dadbod",
		"https://github.com/kristijanhusak/vim-dadbod-completion",
		"https://github.com/kristijanhusak/vim-dadbod-ui",
	})
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "sql", "psql", "mysql", "plsql" },
	callback = function() packadd() end,
})

vim.api.nvim_create_user_command("DBUI", function()
	vim.api.nvim_del_user_command("DBUI")
	packadd()
	vim.cmd("DBUI")
end, {})
