local colors = require("nebula.colors")

local M = {}

M.branch = { "branch", color = { fg = colors.basic.orange } }
M.diff = { "diff", symbols = { added = " ", modified = " ", removed = " " } }

return M
