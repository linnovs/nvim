local gh = require("kuuga.helper.gh")
local usercmd = require("kuuga.lib.pack-usercmd").user_command
local keymap = require("kuuga.lib.keymap")

local function packadd() vim.pack.add({ gh("dlyongemallo/diffview.nvim") }) end

usercmd("DiffviewOpen", packadd)
usercmd("DiffviewFileHistory", packadd)
usercmd("DiffviewDiffFiles", packadd)

keymap("n", "<Leader>dvo", "<Cmd>DiffviewOpen<CR>", "Open Diffview")
