vim.opt.foldcolumn = "1"
vim.opt.foldtext = ""
vim.opt.signcolumn = "yes:1"
vim.opt.fillchars:append({
	fold = " ",
	foldopen = " ",
	foldclose = "",
	foldsep = " ",
	foldinner = " ",
})

vim.o.statuscolumn = "%!v:lua.require'kuuga.statuscol'.render()"

local refresh_interval = 50

local timer = vim.uv.new_timer()
if timer == nil then error("Failed to create timer") end
timer:start(refresh_interval, refresh_interval, vim.schedule_wrap(require("kuuga.statuscol").reset))
