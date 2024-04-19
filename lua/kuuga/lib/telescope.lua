local telescope = require("telescope")
local actions = require("telescope.actions")
local config = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

table.insert(vimgrep_arguments, "--hidden") -- include the hidden files (dot files)
-- Ignore all file in .git
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

vim.api.nvim_create_autocmd("FileType", {
	pattern = "TelescopeResults",
	callback = function(ctx)
		vim.api.nvim_buf_call(ctx.buf, function()
			vim.fn.matchadd("TelescopeParent", "\t\t.*$")
			vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
		end)
	end,
})

local function flash(prompt_bufnr)
	require("flash").jump({
		pattern = "^",
		label = { after = { 0, 0 } },
		search = {
			mode = "search",
			exclude = {
				function(win)
					return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
				end,
			},
		},
		action = function(match)
			local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
			picker:set_selection(match.pos[1] - 1)
		end,
	})
end

-- from https://github.com/nvim-telescope/telescope.nvim/issues/2014#issuecomment-1878409284
local function filename_first(_, path)
	local tail = vim.fs.basename(path)
	local parent = vim.fs.dirname(path)
	if parent == "." then
		return tail
	end
	return string.format("%s\t\t%s", tail, parent)
end

telescope.setup({
	defaults = {
		vimgrep_arguments = vimgrep_arguments,
		sorting_strategy = "ascending",
		layout_config = {
			prompt_position = "top",
			horizontal = {
				mirror = false,
			},
			vertical = {
				mirror = false,
			},
		},
		set_env = { ["COLORTERM"] = "truecolor" },
		mappings = {
			n = {
				s = flash,
			},
			i = {
				["<ESC>"] = actions.close,
				["<C-h>"] = "which_key",
				["<C-s>"] = flash,
			},
		},
		path_display = filename_first,
		prompt_prefix = " ",
		selection_caret = " ",
		multi_icon = " ",
	},
	pickers = {
		find_files = {
			hidden = true,
			follow = true,
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
		buffers = {
			theme = "dropdown",
			mappings = {
				i = {
					["<C-d>"] = actions.delete_buffer,
				},
			},
		},
		help_tags = {
			theme = "dropdown",
			mappings = {
				i = {
					["<CR>"] = actions.select_vertical,
				},
			},
		},
		man_pages = {
			sections = { "ALL" },
			mappings = {
				i = {
					["<CR>"] = actions.select_vertical,
				},
			},
		},
		zoxide = {
			theme = "dropdown",
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		zoxide = {
			mappings = {
				default = {
					after_action = function(selection)
						vim.notify("Directory changed to " .. selection.path)
					end,
				},
			},
		},
		["ui-select"] = {},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("zoxide")
telescope.load_extension("noice")
