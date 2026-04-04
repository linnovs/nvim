vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind

		vim.notify("Plugins " .. name .. " have been changed(" .. kind .. "), reloading...", vim.log.levels.INFO)
	end,
})
