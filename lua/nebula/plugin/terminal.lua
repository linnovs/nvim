local fterm = require("FTerm")
local vimp = require("vimp")

fterm.setup({
	border = "single",
})

vimp.nnoremap("<Leader>tt", function()
	fterm.toggle()
end)

vimp.tnoremap("<Leader>tt", "<CMD>lua require('FTerm').toggle()<CR>")

vimp.nnoremap("<Leader>gst", function()
	fterm.scratch({ cmd = "lazygit" })
end)
