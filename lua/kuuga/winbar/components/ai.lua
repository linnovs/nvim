---@param active boolean
return function(active)
	local ok, status = pcall(require, "sidekick.status")
	if not ok or #status.cli() == 0 then return "" end

	return table.concat({
		active and "%$WinBarAIIcon$" or "",
		"󱚝 ",
	})
end
