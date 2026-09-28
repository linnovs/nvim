---@param active boolean
return function(active)
	local ok, status = pcall(require, "sidekick.status")
	if not ok then return "" end

	local sts = status.cli()
	if #sts > 0 then return "󱚝" end
	return ""

	return table.concat({
		active and "%WinBarAIIcon$" or "",
	})
end
