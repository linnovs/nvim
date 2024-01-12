local colors = require("catppuccin.palettes").get_palette("macchiato") or {}

local M = {}

M[1] = "location"
M.icon = ""
M.color = { fg = colors.teal, bg = colors.overlay0 }

return M
