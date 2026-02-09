local M = {}

M.mode = require("kuuga.lib.statusline.components.mode")
M.macro = require("kuuga.lib.statusline.components.macro")
M.branch = require("kuuga.lib.statusline.components.branch")
M.lazy_update = require("kuuga.lib.statusline.components.lazy")
M.empty = require("kuuga.lib.statusline.components.empty")
M.ruler = require("kuuga.lib.statusline.components.ruler")
M.selectioncount = require("kuuga.lib.statusline.components.selectioncount")
M.progress = require("kuuga.lib.statusline.components.progress")
M.diagnostic = require("kuuga.lib.statusline.components.diagnostics")
M.lsp_status = require("kuuga.lib.statusline.components.lsp_status")
M.copilot = require("kuuga.lib.statusline.components.copilot")

local file = require("kuuga.lib.statusline.components.file")
M.fileicon = file.icon
M.filetype = file.type
M.filename = file.name
M.encoding = file.encoding
M.fileformat = file.format

return M
