local gps = require("nvim-gps")

local M = {}

M[1] = gps.get_location
M.cond = gps.is_available

return M
