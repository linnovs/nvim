return {
	{
		"3rd/image.nvim",
		event = "BufReadPost",
		version = false,
		---@module "image"
		---@type Options
		opts = {
			backend = "kitty",
			kitty_method = "normal",
			integrations = {
				markdown = {
					enabled = true,
					only_render_image_at_cursor = true,
					resolve_image_path = function(document_path, image_path, fallback)
						local working_dir = vim.fn.getcwd()
						-- format image path for obsidian notes
						if working_dir:find("/home/linnovs/Documents/Obsidian Vault") then
							return working_dir .. "/" .. image_path
						end

						return fallback(document_path, image_path)
					end,
				},
			},
			tmux_show_only_in_active_window = true,
		},
	},
}
