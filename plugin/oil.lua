local detail = false
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.pack.add({ { src = "https://github.com/stevearc/oil.nvim", version = vim.version.range("*") } })
		require("kuuga.lib.keymap")("n", "<Leader>of", "<Cmd>Oil<CR>", "Open oil (File explorer)")
		require("oil").setup({
			default_file_explorer = true,
			watch_for_changes = true,
			lsp_file_methods = { autosave_changes = "unmodified" },
			keymaps = {
				["<Leader>wv"] = "actions.select_vsplit",
				["gd"] = {
					desc = "Toggle detail view",
					callback = function()
						detail = not detail
						if detail then
							require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
						else
							require("oil").set_columns({ "icon" })
						end
					end,
				},
				["<C-s>"] = false,
			},
		})
	end,
})
