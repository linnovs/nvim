local colors = require("tokyonight.colors").setup()
local hl = require("kuuga.lib.highlight")

hl("WinBar", colors.fg_dark)
hl("WinBarNC", colors.fg_gutter)

hl("WinBarFilepathLogo", colors.blue2, nil, { "bold" })
hl("WinBarFilepathPart", colors.fg_dark, nil, { "bold" })

hl("WinBarGrammarIcon", colors.rainbow[2])

hl("WinBarCopilotIcon", colors.green1)

hl("WinBarLSPIcon", colors.green2)
hl("WinBarLSPName", colors.cyan)
hl("WinBarLSPDisabled", colors.fg_gutter)
hl("WinBarLSP", colors.fg_dark)

hl("WinBarSearchCountIcon", colors.blue1)
hl("WinBarSearchCountCount", colors.fg_dark)
