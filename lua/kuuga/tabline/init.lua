require("kuuga.tabline.highlights")
require("kuuga.tabline.tabline")

TabLine.refresh()
vim.opt.tabline = "%!v:lua.TabLine.render()"
