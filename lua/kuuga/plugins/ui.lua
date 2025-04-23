return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		---@module "noice"
		---@type NoiceConfig
		---@diagnostic disable-next-line: missing-fields
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				progress = { enabled = true },
				signature = { enabled = false },
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
						},
					},
					view = "notify",
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_name = false,
				lsp_doc_border = true,
			},
		},
		keys = {
			{
				"<C-f>",
				function()
					if not require("noice.lsp").scroll(4) then return "<C-f>" end

					return ""
				end,
				mode = { "n", "i", "s" },
				silent = true,
				expr = true,
			},
			{
				"<C-b>",
				function()
					if not require("noice.lsp").scroll(-4) then return "<C-b>" end

					return ""
				end,
				mode = { "n", "i", "s" },
				silent = true,
				expr = true,
			},
		},
	},

	-- beauty default UI
	{
		"stevearc/dressing.nvim",
		event = "BufReadPost",
		opts = {},
	},
}
