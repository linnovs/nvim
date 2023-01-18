local fortune = require("alpha.fortune")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
	".                                              .",
	"d.                                            .d",
	"xx:                                          :xx",
	"xxxxo:.               ,oo'               .;oxxxx",
	"xxxxxxxxo:'           ;xx,           ':oxxxxxxxx",
	"xxxxxxxxxxxxdc'.      ;xx,      .':dxxxxxxxxxxxx",
	".':oxxxxxxxxxxxxdc'.  ;xx,  .'cdxxxxxxxxxxxxo:'.",
	"     .,cdxxxxxxxxxxxd.;xx,.dxxxxxxxxxxxdc;.",
	"          .;lxxxxxxxx,;xx,,xxxxxxxxl;.",
	"       lxl.   .':oxxx,;xx,,xxxo:'.   .lxl",
	"       lxx.       xxx,;xx,,xxx       .xxl",
	"       lxx.       xxx,;xx,,xxx       .xxl",
	"       lxx.      .xxx,;xx,,xxx.      .xxl",
	"       lxx.  .,cdxxxx,;xx,,xxxxdc;.  .xxl",
	"       lxxloxxxxxxxo:,lxxc,:oxxxxxxxolxxl",
	"       ;xxxxxxxoc::lxxxxxxxxc:::oxxxxxxx;",
	"         .co:::lxxxxxxd::dxxxxxxl:::oc.",
	"            .xxxxxo:'.    .':oxxxxx.",
	"            .xxl.  .dx'  ,xd.  .lxx.",
	"            .xx,   .xx'  ,xx.   ;xx.",
	"            .xxc.  .xx'  ,xx.  .cxx.",
	"            .xxxxd:;xx'  ,xx;:dxxxx",
	"              .;oxxxxx'  ,xxxxxo;.",
	"                  'cdx'  ,xdc'",
	"                     ,.  ',",
}

dashboard.section.header.opts.hl = "Identifier"

dashboard.section.buttons.val = {
	dashboard.button("n", "  > New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("f", "  > Find file", ":Telescope find_files<CR>"),
	dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
	dashboard.button("z", "  > Project", ":Telescope zoxide list<CR>"),
	dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | pwd<CR>"),
	dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
}

dashboard.section.footer.val = fortune()

return dashboard
