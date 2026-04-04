vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		print("PackChanged event triggered for pack: " .. ev.data.pack)
	end,
})
