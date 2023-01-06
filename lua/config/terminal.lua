local fterm = require("FTerm")
local vimp = require("vimp")

fterm.setup({
    border = "single",
})

vimp.nnoremap("<Leader>tt", function()
    fterm.toggle()
end)

vimp.tnoremap("<Leader>tt", "<CMD>lua require('FTerm').toggle()<CR>")

local lg = fterm:new({
    cmd = "lazygit",
})

vimp.nnoremap("<Leader>gst", function()
    lg:toggle()
end)
