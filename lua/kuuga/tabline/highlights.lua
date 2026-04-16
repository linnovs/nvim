local colors = require("tokyonight.colors").setup()
local hl = require("kuuga.lib.highlight")

hl("TabLine", colors.fg_gutter)
hl("TabLineSel", colors.fg_dark, nil, { "bold" })
hl("TabLineFill", colors.fg_dark)

hl("TabLineWindowIndex", colors.blue5, nil, { "bold" })
hl("TabLineWindowActive", colors.fg_dark, nil, { "bold" })
hl("TabLineWindowInactive", colors.fg_gutter)
hl("TabLineWindowModified", colors.yellow, nil, { "bold" })
hl("TabLineWindowReadonly", colors.comment, nil, { "bold" })

hl("TabLineTabActive", colors.fg_dark, nil, { "bold" })
hl("TabLineTabInactive", colors.fg_gutter)
hl("TabLineTabNumber", colors.green)

hl("TabLineTabClose", colors.red, nil, { "bold" })
hl("TabLineTabCloseInactive", colors.fg_gutter, nil, { "bold" })
