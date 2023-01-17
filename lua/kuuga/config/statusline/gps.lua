local navic = require("nvim-navic")

local M = {}

M[1] = navic.get_location
M.cond = navic.is_available

return M
