return {
	function() return " " end,
	color = function()
		local status = require("sidekick.status")
		if status then
			return status.kind == "Error" and "DiagnosticError" or status.busy and "DiagnosticWarn" or "DiagnosticInfo"
		end
	end,
	cond = function()
		local status = require("sidekick.status")
		return status.get() ~= nil
	end,
}
