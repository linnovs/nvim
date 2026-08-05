local detail = false
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.pack.add({ { src = "https://github.com/stevearc/oil.nvim", version = vim.version.range("*") } })
		require("oil").setup({
			default_file_explorer = true,
			watch_for_changes = true,
			lsp_file_methods = { autosave_changes = "unmodified" },
			keymaps = {
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
				["<CR>"] = {
					function()
						local oil = require("oil")
						local entry = oil.get_cursor_entry()
						local dir = oil.get_current_dir()

						if entry and entry.type == "file" and dir then
							vim.fn.jobstart({ "zeditor", dir .. entry.name }, { detatch = true })
							vim.cmd("qa!")
						else
							require("oil.actions").select.callback()
						end
					end,
				},
			},
		})
	end,
})
