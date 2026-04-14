local colors = require("tokyonight.colors").setup()
local hl = require("kuuga.lib.highlight")

hl("WinBar", colors.fg_dark)
hl("WinBarNC", colors.fg_gutter)

hl("WinBarFilepathLogo", colors.blue2)

hl("WinBarModified", colors.orange, nil, { "bold" })
hl("WinBarReadonly", colors.red, nil, { "bold" })

hl("WinBarLSPIcon", colors.green2)
hl("WinBarLSPName", colors.cyan)
hl("WinBarLSPDisabled", colors.fg_gutter)
hl("WinBarLSP", colors.fg_dark)
