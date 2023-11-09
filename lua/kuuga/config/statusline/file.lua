local M = {}

M.icon = { "filetype", icon_only = true, padding = { left = 1, right = 0 } }
M.name = { "filename", symbols = { modified = " ✏️ ", readonly = " 🔒" } }
M.location = { "location", color = { fg = "#24273a", bg = "#b7bdf8" } }
M.encoding = { "encoding", separator = "" }
M.format = { "fileformat", symbols = { unix = " ", dos = " ", mac = " " }, separator = "" }
M.type = { "filetype", separator = "" }

return M
