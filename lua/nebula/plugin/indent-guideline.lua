require("indent_blankline").setup({
	char = "",
	buftype_exclude = { "terminal", "help" },
	filetype_exclude = { "lsp-installer", "alpha", "packer" },
	space_char_blankline = " ",
	show_current_context = true,
	use_treesitter = true,
})
