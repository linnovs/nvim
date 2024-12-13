local colors = require("catppuccin.palettes").get_palette("macchiato") or {}

local M = {}

M[1] = "selectioncount"
M.icon = ""
M.color = { fg = colors.teal, bg = colors.overlay0 }
M.padding = { left = 0, right = 1 }

return M
