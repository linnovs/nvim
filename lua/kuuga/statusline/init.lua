require("kuuga.statusline.highlights")
require("kuuga.statusline.statusline")

StatusLine.refresh()
vim.go.statusline = "%!v:lua.StatusLine.render()"
