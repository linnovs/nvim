local ok, wakatime = pcall(require, "wakatime")
local today_summary = ""
local timer = vim.uv.new_timer()

if not ok or timer == nil then
	vim.notify(wakatime)
	return function() return "wakatime failed" end
end

timer:start(
	0,
	1000 * 60,
	vim.schedule_wrap(function()
		wakatime.get_today_summary(function(msg) today_summary = msg end)
	end)
)

return function()
	return table.concat({
		"%#StatusLineWakaTimeIcon#",
		"󱑁 ",
		"%#StatusLineWakaTimeLine#",
		today_summary,
	})
end
