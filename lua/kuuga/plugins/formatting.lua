return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = "ConformInfo",
	init = function() vim.o.formatexpr = "v:lua.require('conform').formatexpr()" end,
	keys = {
		{
			"<Leader>f",
			function() require("conform").format({ lsp_format = "fallback", async = true }) end,
			mode = "",
			desc = "Format buffer",
		},
	},
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		format_on_save = function(bufnr)
			-- Disable with a global or buffer-local variable
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
			return { timeout_ms = 500, lsp_format = "fallback" }
		end,
		formatters_by_ft = {
			["*"] = { "trim_whitespace" },
			go = { "goimports", "golines", "gofumpt" },
			javascript = { "biome", "biome-organize-imports" },
			javascriptreact = { "biome", "biome-organize-imports" },
			typescript = { "biome", "biome-organize-imports" },
			typescriptreact = { "biome", "biome-organize-imports" },
			vue = { "biome", "biome-organize-imports" },
			lua = { "stylua" },
			markdown = { "injected" },
			nix = { "nixpkgs_fmt" },
			proto = { "protolint" },
			python = { "ruff_fix", "ruff_format" },
			rust = { "rustfmt" },
			yaml = { "yamlfmt" },
			http = { "kulala" },
		},
		formatters = {
			prettierd = {
				env = {
					PRETTIERD_DEFAULT_CONFIG = vim.fn.stdpath("config") .. "/.prettierrc.json",
				},
			},
			kulala = {
				command = "kulala-fmt",
				args = { "format", "$FILENAME" },
				stdin = false,
			},
		},
		notify_on_error = true,
	},
}
