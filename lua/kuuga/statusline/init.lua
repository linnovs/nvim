require("kuuga.statusline.highlights")
require("kuuga.statusline.statusline")

vim.opt.statusline = "%!v:lua.StatusLine.render()"
