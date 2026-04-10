local api = vim.api
local augroup = api.nvim_create_augroup("KuugaUI2", { clear = true })

require("kuuga.ui2.enable")
require("kuuga.ui2.cmdline").setup(augroup, { "/", "?" })
