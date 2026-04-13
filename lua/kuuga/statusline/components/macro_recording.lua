return function()
	local register = vim.fn.reg_recording()
	if register == "" then return "" end

	return table.concat({
		"%#StatuslineMacroRecordingIcon#",
		"󰰟 ",
		"%#StatuslineMacroRecording#",
		"Recording ",
		"%#StatuslineMacroRecordingReg#",
		"@" .. register,
		"%*",
	})
end
