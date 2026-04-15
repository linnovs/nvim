local gh = require("kuuga.helper.gh")
local usercmd = require("kuuga.lib.pack-usercmd").user_command

local function packadd() vim.pack.add({ gh("sindrets/diffview.nvim") }) end

usercmd("DiffviewOpen", packadd)
usercmd("DiffviewFileHistory", packadd)
