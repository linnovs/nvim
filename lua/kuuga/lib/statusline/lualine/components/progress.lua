local colors = require("catppuccin.palettes").get_palette("macchiato") or {}

local M = {}

M[1] = "progress"
M.color = { fg = colors.base, bg = colors.teal }
M.separator = { left = "" }

return M
