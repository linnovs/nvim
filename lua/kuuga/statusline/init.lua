require("kuuga.statusline.highlights")
require("kuuga.statusline.statusline")

StatusLine.refresh()
vim.opt.statusline = "%!v:lua.StatusLine.render()"
