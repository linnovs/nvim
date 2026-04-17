local gh = require("kuuga.helper.gh")
local usercmd = require("kuuga.lib.pack-usercmd").user_command
local keymap = require("kuuga.lib.keymap")

local need_setup = true
local function setup()
	if need_setup then
		require("diffview").setup({
			enhanced_diff_hl = true,
			keymaps = {
				file_panel = {
					{ { "n", "x" }, "<space>", false },
				},
			},
		})
		need_setup = false
	end
end
local function packadd()
	vim.pack.add({ gh("dlyongemallo/diffview.nvim") })
	setup()
end

usercmd("DiffviewOpen", packadd)
usercmd("DiffviewToggle", packadd)
usercmd("DiffviewFileHistory", packadd)
usercmd("DiffviewDiffFiles", packadd)

keymap("n", "<Leader>dv", "<Cmd>DiffviewToggle<CR>", "Open Diffview")
