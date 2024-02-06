-- copilot
-- return {
-- 	"zbirenbaum/copilot.lua",
-- 	cmd = "Copilot",
-- 	event = "InsertEnter",
-- 	opts = {
-- 		suggestion = {
-- 			enabled = true,
-- 			auto_trigger = false,
-- 			keymap = {
-- 				accept = false,
-- 				accept_word = false,
-- 				accept_line = false,
-- 				next = "<C-n>",
-- 				prev = "<C-p>",
-- 				dismiss = false,
-- 			},
-- 		},
-- 		panel = { enabled = false },
-- 	},
-- 	config = function(_, opts)
-- 		vim.defer_fn(function()
-- 			vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
-- 			require("copilot").setup(opts)
-- 		end, 100)
-- 	end,
-- },

-- codeium
return {
	"Exafunction/codeium.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	event = "InsertEnter",
	opts = {},
}
