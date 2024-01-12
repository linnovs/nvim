local M = {}

M.mode = require("kuuga.lib.statusline.lualine.components.mode")
M.macro = require("kuuga.lib.statusline.lualine.components.macro")
M.lsp = require("kuuga.lib.statusline.lualine.components.lsp")
M.git_status = require("kuuga.lib.statusline.lualine.components.git")
M.lazy_update = require("kuuga.lib.statusline.lualine.components.lazy")
M.empty = require("kuuga.lib.statusline.lualine.components.empty")
M.ruler = require("kuuga.lib.statusline.lualine.components.ruler")
M.selectioncount = require("kuuga.lib.statusline.lualine.components.selectioncount")
M.progress = require("kuuga.lib.statusline.lualine.components.progress")

local file = require("kuuga.lib.statusline.lualine.components.file")
M.fileicon = file.icon
M.filetype = file.type
M.filename = file.name
M.encoding = file.encoding
M.fileformat = file.format

local diagnostics = require("kuuga.lib.statusline.lualine.components.diagnostics")
M.diagnostic_error = diagnostics.error
M.diagnostic_warn = diagnostics.warn
M.diagnostic_info = diagnostics.info
M.diagnostic_hint = diagnostics.hint

return M
