local colors = require("nebula.colors")
local lsp = colors.lsp
local git = colors.git

local autocmds = {
    set_formatoptions = {
        { event = "BufEnter", opts = { pattern = "*", command = "setlocal formatoptions-=o" } },
    },
    LspColors = {
        {
            event = "ColorScheme",
            opts = {
                pattern = "*",
                callback = function()
                    vim.api.nvim_exec(
                        string.format(
                            [[
highlight DiagnosticError guifg=%s
highlight DiagnosticWarn guifg=%s
highlight DiagnosticInfo guifg=%s
highlight DiagnosticHint guifg=%s
highlight DiagnosticUnderlineError gui=undercurl guisp=%s
highlight DiagnosticUnderlineWarn gui=undercurl guisp=%s
highlight DiagnosticUnderlineInfo gui=undercurl guisp=%s
highlight DiagnosticUnderlineHint gui=undercurl guisp=%s
            ]]               ,
                            lsp.error,
                            lsp.warning,
                            lsp.information,
                            lsp.hint,
                            lsp.error,
                            lsp.warning,
                            lsp.information,
                            lsp.hint
                        ),
                        false
                    )
                end,
            },
        },
    },
    GitSignColors = {
        {
            event = "ColorScheme",
            opts = {
                pattern = "*",
                callback = function()
                    vim.api.nvim_exec(
                        string.format(
                            [[
highlight GitSignsAdd guifg=%s
highlight GitSignsChange guifg=%s
highlight GitSignsDelete guifg=%s
            ]]               ,
                            git.added,
                            git.modified,
                            git.removed
                        ),
                        false
                    )
                end,
            },
        },
    },
    ChezmoiApply = {
        {
            event = "BufWritePost",
            opts = {
                pattern = "~/.local/share/chezmoi/*",
                callback = function(args)
                    if string.sub(args.file, 1, string.len("run_")) == "run_" then
                        return
                    end
                    os.execute("chezmoi apply --source-path " .. args.file)
                    vim.notify("Update source " .. args.file .. " to target")
                end,
            },
        },
    },
    I3AutoReload = {
        {
            event = "BufWritePost",
            opts = {
                pattern = "~/.local/share/chezmoi/dot_config/i3/config",
                callback = function()
                    os.execute("i3-msg reload")
                    vim.notify("Reload i3")
                end,
            },
        },
    },
    AutoPackerSync = {
        {
            event = "BufWritePost",
            opts = { pattern = "~/.config/nvim/lua/plugins.lua", command = "so % | PackerSync" },
        },
    },
    MyAutoFT = {
        { event = { "BufRead", "BufNewFile" }, opts = { pattern = "*.tf", command = "set filetype=terraform" } },
        { event = { "BufRead", "BufNewFile" }, opts = { pattern = "*.rasi", command = "set filetype=rasi" } },
        { event = { "BufRead", "BufNewFile" }, opts = { pattern = "*.wgsl", command = "set filetype=wgsl" } },
    },
}

require("nebula.nvim_augroup").creates(autocmds)
