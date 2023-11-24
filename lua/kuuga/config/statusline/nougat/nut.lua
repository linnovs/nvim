local nut = {
	buf = {
		diagnostic_count = require("nougat.nut.buf.diagnostic_count").create,
		filename = require("nougat.nut.buf.filename").create,
		filetype = require("nougat.nut.buf.filetype").create,
	},
	git = {
		branch = require("nougat.nut.git.branch").create,
		status = require("nougat.nut.git.status"),
	},
	tab = {
		tablist = {
			tabs = require("nougat.nut.tab.tablist").create,
			close = require("nougat.nut.tab.tablist.close").create,
			icon = require("nougat.nut.tab.tablist.icon").create,
			label = require("nougat.nut.tab.tablist.label").create,
			modified = require("nougat.nut.tab.tablist.modified").create,
		},
	},
	mode = require("nougat.nut.mode").create,
	spacer = require("nougat.nut.spacer").create,
	truncation_point = require("nougat.nut.truncation_point").create,
}

return nut
