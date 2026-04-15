local colors = require("tokyonight.colors").setup()
local hl = require("kuuga.lib.highlight")

hl("StatusLine", colors.fg_dark)
hl("StatusLineLogo", colors.fg_gutter)
hl("StatusLineTerm", colors.fg_dark)

hl("StatusLineModeNormal", colors.green1, nil, { "bold" })
hl("StatusLineModeVisual", colors.blue, nil, { "bold" })
hl("StatusLineModeInsert", colors.orange, nil, { "bold" })
hl("StatusLineModeReplace", colors.red, nil, { "bold" })
hl("StatusLineModeCommand", colors.yellow, nil, { "bold" })
hl("StatusLineModeTerminal", colors.purple, nil, { "bold" })

hl("StatusLineGitBranchIcon", colors.orange, nil, { "bold" })
hl("StatusLineGitBranchName", colors.fg_dark)

hl("StatusLineGitDiff", colors.fg_dark)
hl("StatusLineGitDiffAdded", colors.green2)
hl("StatusLineGitDiffModified", colors.blue1)
hl("StatusLineGitDiffDeleted", colors.red1)

hl("StatusLineMacroRecordingIcon", colors.red, nil, { "bold" })
hl("StatusLineMacroRecordingReg", colors.yellow)
hl("StatusLineMacroRecording", colors.fg_dark)

hl("StatusLineBufferInfoIcon", colors.blue)
hl("StatusLineBufferInfoSCharIcon", colors.blue)
hl("StatusLineBufferInfoSLineIcon", colors.blue)
hl("StatusLineBufferInfoLine", colors.fg_dark)

hl("StatusLineLineInfoIcon", colors.blue5)
hl("StatusLineLineInfoLine", colors.fg_dark)

hl("StatusLineFiletype", colors.fg_dark)

hl("StatusLineScrollbar", colors.blue2)
