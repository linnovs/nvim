local gh = require("kuuga.helper.gh")

vim.pack.add({ { src = gh("stevearc/conform.nvim"), version = vim.version.range("*") } })
vim.opt.formatexpr = 'v:lua.require("conform").formatexpr()'

require("kuuga.lib.keymap")(
	"n",
	"<Leader>f",
	function() require("conform").format({ lsp_format = "fallback", async = true }) end,
	"Format buffer"
)

require("conform").setup({
	format_on_save = function(bufnr)
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
		return { timeout_ms = 500, lsp_format = "fallback" }
	end,
	notify_on_error = true,
})
