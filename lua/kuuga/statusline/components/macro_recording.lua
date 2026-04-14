return function()
	local register = vim.fn.reg_recording()
	if register == "" then return "" end

	return table.concat({
		"%#StatusLineMacroRecordingIcon#",
		"󰑋 ",
		"%#StatusLineMacroRecording#",
		"Recording ",
		"%#StatusLineMacroRecordingReg#",
		"@" .. register,
		"%*",
	})
end
