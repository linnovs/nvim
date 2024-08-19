return {
	"RRethy/vim-illuminate",
	event = "BufRead",
	opts = {
		delay = 200,
		large_file_cutoff = 2000,
		large_file_overrides = {
			providers = { "lsp" },
		},
	},
	config = function(_, opts)
		require("illuminate").configure(opts)
		local keymap = require("kuuga.lib.keymap")

		local function map(lhs, dir, buffer)
			local fn = function()
				require("illuminate")["goto_" .. dir .. "_reference"](false)
			end
			local desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference"
			keymap.map("n", lhs, fn, desc, { buffer = buffer })
		end

		map("]]", "next")
		map("[[", "prev")

		-- also set it after loading ftplugins, since a lot overwrite [[ and ]]
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				local bufnr = vim.api.nvim_get_current_buf()
				map("]]", "next", bufnr)
				map("[[", "prev", bufnr)
			end,
		})
	end,
	keys = {
		{ "]]" },
		{ "[[" },
	},
}
