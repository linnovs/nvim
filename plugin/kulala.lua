local gh = require("kuuga.helper.gh")

local function packadd()
	vim.pack.add({
		gh("mistweaverco/kulala.nvim"),
	})
	require("kulala").setup({
		global_keymaps = true,
	})
end

require("kuuga.lib.ft-autocmd").autocmd(function() packadd() end, { pattern = { "http", "rest" } })
