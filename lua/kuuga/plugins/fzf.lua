return {
	"ibhagwan/fzf-lua",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
	},
	keys = {
		-- stylua: ignore start
        { "<leader><leader>", function() require("fzf-lua").files() end, desc = "Fzf find files", },
        { "<leader>fg", function() require("fzf-lua").live_grep() end, desc = "Fzf find in files (ripgrep)", },
        { "<leader>fb", function() require("fzf-lua").buffers() end, desc = "Fzf find buffers", },
        { "<leader>fh", function() require("fzf-lua").helptags() end, desc = "Fzf find help tags", },
        { "<leader>fm", function() require("fzf-lua").manpages() end, desc = "Fzf find man pagse", },
        { "<leader>fs", function() require("fzf-lua").lsp_document_symbols() end, desc = "Fzf find document symbols", },
        { "<leader>fw", function() require("fzf-lua").lsp_workspace_symbols() end, desc = "Fzf find workspace symbols", },
		{ "<leader>fc", function() require("kuuga.lib.cht-st").cht_sh_list() end, desc = "Fzf find cht.sh", },
		{ "<leader>sc", function() require("kuuga.lib.cht-st").query_cht_sh() end, desc = "Fzf search cht.sh", },
		-- stylua: ignore end
	},
	opts = {},
}
