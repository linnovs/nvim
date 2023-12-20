local fortune = require("kuuga.lib.fortune")
local M = {}

M.theme = "doom"
M.config = {}
M.config.header = {
	".                                              . ",
	"d.                                            .d ",
	"xx:                                          :xx ",
	"xxxxo:.               ,oo'               .;oxxxx ",
	"xxxxxxxxo:'           ;xx,           ':oxxxxxxxx ",
	"xxxxxxxxxxxxdc'.      ;xx,      .':dxxxxxxxxxxxx ",
	".':oxxxxxxxxxxxxdc'.  ;xx,  .'cdxxxxxxxxxxxxo:'. ",
	"     .,cdxxxxxxxxxxxd.;xx,.dxxxxxxxxxxxdc;.      ",
	"          .;lxxxxxxxx,;xx,,xxxxxxxxl;.           ",
	"       lxl.   .':oxxx,;xx,,xxxo:'.   .lxl        ",
	"       lxx.       xxx,;xx,,xxx       .xxl        ",
	"       lxx.       xxx,;xx,,xxx       .xxl        ",
	"       lxx.      .xxx,;xx,,xxx.      .xxl        ",
	"       lxx.  .,cdxxxx,;xx,,xxxxdc;.  .xxl        ",
	"       lxxloxxxxxxxo:,lxxc,:oxxxxxxxolxxl        ",
	"       ;xxxxxxxoc::lxxxxxxxxc:::oxxxxxxx;        ",
	"         .co:::lxxxxxxd::dxxxxxxl:::oc.          ",
	"            .xxxxxo:'.    .':oxxxxx.             ",
	"            .xxl.  .dx'  ,xd.  .lxx.             ",
	"            .xx,   .xx'  ,xx.   ;xx.             ",
	"            .xxc.  .xx'  ,xx.  .cxx.             ",
	"            .xxxxd:;xx'  ,xx;:dxxxx              ",
	"              .;oxxxxx'  ,xxxxxo;.               ",
	"                  'cdx'  ,xdc'                   ",
	"                     ,.  ',                      ",
}

local settings_action = "e $MYVIMRC | cd %:p:h | lua vim.notify('Changed to nvimrc')"

-- stylua: ignore
M.config.center = {
	{ key = "n", icon = "󰝒 ", desc = " > New file",    action = "ene | startinsert" },
	{ key = "f", icon = "󰈞 ", desc = " > Find file",   action = "Telescope find_files" },
	{ key = "r", icon = "󱋡 ", desc = " > Recent",      action = "Telescope oldfiles" },
	{ key = "z", icon = "󱧶 ", desc = " > Project",     action = "Telescope zoxide list" },
	{ key = "s", icon = "󱁻 ", desc = " > Settings",    action = settings_action },
	{ key = "q", icon = "󰮘 ", desc = " > Quit NVIM",   action = "qa" },
}

M.config.footer = fortune

for _, button in ipairs(M.config.center) do
	button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
end

M.hide = {
	statusline = true,
	tabline = true,
	winbar = true,
}

return M
