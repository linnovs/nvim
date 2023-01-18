local autocmd = vim.api.nvim_create_autocmd
local colors = require("kuuga.colors")
local lsp = colors.lsp
local git = colors.git
local home = vim.fn.expand("~")

autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })
autocmd("VimResized", { command = "tabdo wincmd =" })
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

autocmd("ColorScheme", {
	callback = function()
		vim.api.nvim_exec(
			string.format(
				[[
highlight DiagnosticError guifg=%s
highlight DiagnosticWarn guifg=%s
highlight DiagnosticInfo guifg=%s
highlight DiagnosticHint guifg=%s
highlight DiagnosticUnderlineError gui=undercurl guisp=%s
highlight DiagnosticUnderlineWarn gui=undercurl guisp=%s
highlight DiagnosticUnderlineInfo gui=undercurl guisp=%s
highlight DiagnosticUnderlineHint gui=undercurl guisp=%s
]],
				lsp.error,
				lsp.warn,
				lsp.info,
				lsp.hint,
				lsp.error,
				lsp.warn,
				lsp.info,
				lsp.hint
			),
			false
		)
		vim.api.nvim_exec(
			string.format(
				[[
highlight GitSignsAdd guifg=%s
highlight GitSignsChange guifg=%s
highlight GitSignsDelete guifg=%s
]],
				git.added,
				git.modified,
				git.removed
			),
			false
		)
	end,
})

autocmd("BufWritePost", {
	pattern = home .. "/.local/share/chezmoi/*",
	callback = function(args)
		local file = args.file:match("^.+/(.+)$")
		if string.sub(file, 1, string.len("run_")) == "run_" then
			return
		end
		os.execute("chezmoi apply --source-path " .. args.file)
		vim.notify("Update source " .. args.file .. " to target")
	end,
})

autocmd("BufWritePost", {
	pattern = home .. "/.local/share/chezmoi/dot_config/i3/config",
	callback = function()
		os.execute("i3-msg reload")
		vim.notify("Reload i3")
	end,
})

autocmd("BufEnter", { pattern = "COMMIT_EDITMSG", command = "startinsert" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.tf", command = "set filetype=terraform" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.rasi", command = "set filetype=rasi" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.wgsl", command = "set filetype=wgsl" })
