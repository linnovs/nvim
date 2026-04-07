vim.pack.add({ { src = "https://github.com/OXY2DEV/markview.nvim", version = vim.version.range("*") } })
local presets = require("markview.presets")

local opts = {
	preview = {
		filetypes = { "markdown" },
		icon_provider = "mini",
		hybrid_modes = { "n" },
		linewise_hybrid_mode = true,
	},
	markdown = {
		headings = presets.headings.glow,
		horizontal_rules = presets.horizontal_rules.thin,
		tables = presets.tables.rounded,
	},
}

require("markview").setup(opts)
require("markview.extras.editor").setup()
