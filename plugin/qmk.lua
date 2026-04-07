require("kuuga.lib.ft-autocmd").autocmd(function()
	vim.pack.add({ "https://github.com/codethread/qmk.nvim" })
	require("qmk").setup({
		name = "LAYOUT",
		comment_preview = {},
		layout = {
			"x x x x x x x _ _ _ _ _ x x x x x x x",
			"x x x x x x x _ _ _ _ _ x x x x x x x",
			"x x x x x x x _ _ _ _ _ x x x x x x x",
			"x x x x x x _ _ _ _ _ _ _ x x x x x x",
			"x x x x x _ x^x _ _ _ x^x _ x x x x x",
			"_ _ _ _ _ _ x x x _ x x x _ _ _ _ _ _",
		},
	})
end, { pattern = "c" })
