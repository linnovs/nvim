local autocmd = vim.api.nvim_create_autocmd
local home = vim.fn.expand("~")

autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })
autocmd("VimResized", { command = "tabdo wincmd =" })
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

autocmd("BufWritePost", {
	pattern = home .. "/.local/share/chezmoi/*",
	callback = function(args)
		local file = args.file:match("^.+/(.+)$") or args.file
		local is_run = string.sub(file, 1, string.len("run_")) == "run_"
		local is_chezmoi = string.sub(file, 1, string.len(".chezmoi")) == ".chezmoi"
		if is_run or is_chezmoi then
			return
		end
		os.execute("chezmoi apply --refresh-externals=never --source-path " .. args.file)
		vim.notify("Apply source " .. args.file .. " to target")
	end,
})

autocmd("BufWritePost", {
	pattern = home .. "/.local/share/chezmoi/dot_config/i3/config",
	callback = function()
		os.execute("i3-msg reload")
		vim.notify("Reload i3")
	end,
})

autocmd({ "BufRead", "BufNewFile" }, {
	pattern = home .. "/Documents/Obsidian Vault/*",
	callback = function()
		vim.opt.conceallevel = 2
		vim.keymap.set("n", "gf", function()
			if require("obsidian").util.cursor_on_markdown_link() then
				return "<CMD>ObsidianFollowLink<CR>"
			else
				return "gf"
			end
		end, { desc = "Follow Obsidian Link", expr = true })
	end,
})

autocmd("BufEnter", { pattern = { "term://*", "*COMMIT_EDITMSG" }, command = "startinsert" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.tf", command = "set filetype=terraform" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.rasi", command = "set filetype=rasi" })
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.wgsl", command = "set filetype=wgsl" })
