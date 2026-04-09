local gh = require("kuuga.lib.pack-source.gh")
vim.g.db_ui_use_nerd_fonts = 1

local function packadd()
	vim.pack.add({
		gh("tpope/vim-dadbod"),
		gh("kristijanhusak/vim-dadbod-completion"),
		gh("kristijanhusak/vim-dadbod-ui"),
	})
end

require("kuuga.lib.ft-autocmd").autocmd(function() packadd() end, { pattern = { "sql", "psql", "mysql", "plsql" } })
require("kuuga.lib.pack-usercmd").user_command("DBUI", function() packadd() end)
