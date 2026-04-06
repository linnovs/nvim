vim.api.nvim_create_autocmd("BufReadPre", {
	callback = function()
		vim.pack.add({ { src = "https://github.com/stevearc/conform.nvim", version = vim.version.range("*") } })
		vim.opt.formatexpr = 'v:lua.require("conform").formatexpr()'

		require("kuuga.lib.keymap")("n", "<Leader>f", function()
			require("conform").format({ lsp_format = "fallback", async = true })
		end, "Format buffer")

		require("conform").setup({
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_format = "fallback" }
			end,
			formatters_by_ft = {
				["*"] = { "trim_whitespace" },
				go = { "goimports", "golines", "gofumpt" },
				javascript = { "biome", "biome-organize-imports" },
				javascriptreact = { "biome", "biome-organize-imports" },
				typescript = { "biome", "biome-organize-imports" },
				typescriptreact = { "biome", "biome-organize-imports" },
				jsonc = { "biome" },
				json = { "biome" },
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
				kulala = {
					command = "kulala-fmt",
					args = { "format", "$FILENAME" },
					stdin = false,
				},
			},
			notify_on_error = true,
		})
	end,
})
