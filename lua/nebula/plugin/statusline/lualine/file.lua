local M = {}

M.icon = { "filetype", icon_only = true, padding = { left = 1, right = 0 } }
M.name = { "filename", symbols = { modified = "  ", readonly = " 🔒" }, separator = " " }
M.location = { "location" }
M.encoding = { "encoding", separator = "" }
M.format = { "fileformat", symbols = { unix = " ", dos = " ", mac = " " }, separator = "" }
M.type = { "filetype", separator = "" }

return M
