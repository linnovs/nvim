return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		---@module "noice"
		---@type NoiceConfig
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				progress = {
					enabled = false,
				},
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
					if not require("noice.lsp").scroll(4) then
						return "<C-f>"
					end

					return ""
				end,
				mode = { "n", "i", "s" },
				silent = true,
				expr = true,
			},
			{
				"<C-b>",
				function()
					if not require("noice.lsp").scroll(-4) then
						return "<C-b>"
					end

					return ""
				end,
				mode = { "n", "i", "s" },
				silent = true,
				expr = true,
			},
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "BufReadPost",
		---@module "ibl"
		---@type ibl.config
		opts = {
			indent = {
				char = "▏",
				tab_char = "▏",
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"FTerm",
					"Trouble",
					"alpha",
					"help",
					"lazy",
					"mason",
					"neo-tree",
					"dashboard",
				},
			},
		},
	},

	-- beauty default UI
	{
		"stevearc/dressing.nvim",
		event = "BufReadPost",
		dependencies = { "nvim-telescope/telescope.nvim" },
		opts = function()
			return {
				select = {
					telescope = require("telescope.themes").get_cursor(),
				},
			}
		end,
	},
}
