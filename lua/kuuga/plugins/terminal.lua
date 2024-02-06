return {
	"akinsho/nvim-toggleterm.lua",
	event = "VeryLazy",
	init = function()
		local group = vim.api.nvim_create_augroup("ToggleTermTernOpenMapping", { clear = true })
		vim.api.nvim_create_autocmd({ "TermOpen" }, {
			group = group,
			pattern = { "term://*:toggleterm:*", "term://*#toggleterm#*" },
			callback = function(ev)
				local bufnr = ev.buf
				local function map(lhs, rhs, desc)
					vim.keymap.set("t", lhs, rhs, { desc = desc, buffer = bufnr })
				end

				map("<leader>wh", "<Cmd>wincmd h<CR>", "Move window to the left")
				map("<leader>wj", "<Cmd>wincmd j<CR>", "Move window to the down")
				map("<leader>wk", "<Cmd>wincmd k<CR>", "Move window to the up")
				map("<leader>wl", "<Cmd>wincmd l<CR>", "Move window to the right")
			end,
		})
	end,
	opts = {
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
		open_mapping = [[<Leader>tt]],
		start_in_insert = true,
		insert_mappings = false,
		terminal_mappings = true,
		persist_size = true,
		persist_mode = true,
		direction = "horizontal",
		close_on_exit = true,
		shell = vim.o.shell,
		auto_scroll = true,
		winbar = {
			enabled = true,
		},
	},
}
