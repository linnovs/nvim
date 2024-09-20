return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"JoosepAlviste/nvim-ts-context-commentstring",
		{ "nvim-treesitter/nvim-treesitter-context", opts = { mode = "cursor" } },
		{ "windwp/nvim-ts-autotag", opts = {} },
	},
	build = ":TSUpdate",
	event = "BufReadPost",
	init = function()
		vim.g.skip_ts_context_commentstring_module = true
	end,
	opts = {
		sync_install = false,
		ensure_installed = {
			"bash",
			"c",
			"css",
			"csv",
			"diff",
			"dockerfile",
			"git_config",
			"git_rebase",
			"gitattributes",
			"gitcommit",
			"gitignore",
			"go",
			"gomod",
			"gosum",
			"html",
			"http",
			"hurl",
			"javascript",
			"jsdoc",
			"json",
			"json5",
			"jsonc",
			"latex",
			"lua",
			"luadoc",
			"luap",
			"markdown",
			"markdown_inline",
			"nix",
			"proto",
			"python",
			"query",
			"rasi",
			"regex",
			"rust",
			"ssh_config",
			"terraform",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"vue",
			"wgsl",
			"yaml",
			"zig",
		},
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
			disable = function(_, buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
		},
		indent = { enable = true },
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
					["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
				},
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
				include_surrounding_whitespace = false,
			},
		},
	},
	config = function(_, opts)
		---@diagnostic disable-next-line: missing-fields
		require("ts_context_commentstring").setup({
			enable_autocmd = false,
		})
		require("nvim-treesitter.configs").setup(opts)
		vim.treesitter.language.register("markdown", "octo")
		vim.treesitter.language.register("gitcommit", "NeogitCommitMessage")

		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	end,
}
