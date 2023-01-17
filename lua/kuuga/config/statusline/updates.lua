local lazyStatus = require("lazy.status")
local M = {}

M[1] = lazyStatus.updates
M.cond = lazyStatus.has_updates
M.color = { fg = "#ff9e64" }

return M
