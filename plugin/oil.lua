vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.pack.add({ "https://github.com/stevearc/oil.nvim" })
		require("kuuga.lib.keymap")("n", "<Leader>of", "<Cmd>Oil<CR>", "Open oil (File explorer)")
		require("oil").setup({
			default_file_explorer = true,
			keymaps = {
				["<Leader>wv"] = "actions.select_vsplit",
				["<C-s>"] = false,
			},
		})
	end,
})
