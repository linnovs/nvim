vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.pack.add({ { src = "https://github.com/stevearc/oil.nvim", version = vim.version.range("*") } })
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
