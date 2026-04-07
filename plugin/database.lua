vim.g.db_ui_use_nerd_fonts = 1

local function packadd()
	vim.pack.add({
		"https://github.com/tpope/vim-dadbod",
		"https://github.com/kristijanhusak/vim-dadbod-completion",
		"https://github.com/kristijanhusak/vim-dadbod-ui",
	})
end

require("kuuga.lib.ft-autocmd").autocmd(function() packadd() end, { pattern = { "sql", "psql", "mysql", "plsql" } })
require("kuuga.lib.pack-usercmd").user_command("DBUI", function() packadd() end)
