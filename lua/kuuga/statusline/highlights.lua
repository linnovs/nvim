local colors = require("tokyonight.colors").setup()
local hl = require("kuuga.lib.highlight")

hl("StatuslineNormal", colors.fg_gutter, colors.bg_statusline)

hl("StatuslineModeNormal", colors.green1, nil, { "bold" })
hl("StatuslineModeVisual", colors.blue, nil, { "bold" })
hl("StatuslineModeInsert", colors.orange, nil, { "bold" })
hl("StatuslineModeReplace", colors.red, nil, { "bold" })
hl("StatuslineModeCommand", colors.yellow, nil, { "bold" })
hl("StatuslineModeTerminal", colors.purple, nil, { "bold" })

hl("StatuslineFilepathIcon", colors.blue2)
hl("StatuslineFilepathTerminal", colors.green)
hl("StatuslineFilepath", colors.fg_dark)

hl("StatuslineFile", colors.fg_dark)
hl("StatuslineFileModified", colors.orange)
hl("StatuslineFileReadonly", colors.fg_gutter)

hl("StatuslineGitBranchIcon", colors.orange, nil, { "bold" })
hl("StatuslineGitBranchName", colors.fg_dark)

hl("StatuslineMacroRecordingIcon", colors.red, nil, { "bold" })
hl("StatuslineMacroRecordingReg", colors.yellow)
hl("StatuslineMacroRecording", colors.fg_dark)

hl("StatuslineLSPIcon", colors.green2)
hl("StatuslineLSPName", colors.cyan)
hl("StatuslineLSPDisabled", colors.fg_gutter)
hl("StatuslineLSP", colors.fg_dark)

hl("StatuslineSearchCountIcon", colors.blue1)
hl("StatuslineSearchCountCount", colors.fg_dark)

hl("StatuslineBufferInfoIcon", colors.blue)
hl("StatuslineBufferInfoSCharIcon", colors.blue)
hl("StatuslineBufferInfoSLineIcon", colors.blue)
hl("StatuslineBufferInfoLine", colors.fg_dark)

hl("StatuslineLineInfoIcon", colors.blue5)
hl("StatuslineLineInfoLine", colors.fg_dark)

hl("StatuslineFiletype", colors.fg_dark)

hl("StatuslineScrollbar", colors.blue2)
