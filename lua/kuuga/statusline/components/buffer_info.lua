local function selected_lines()
	local lines = math.abs(vim.fn.line("v") - vim.fn.line(".")) + 1

	if lines <= 1 then return "" end

	return table.concat({
		"%#StatuslineBufferInfoSLineIcon#",
		" ",
		"%#StatuslineBufferInfoLine#",
		lines,
		" ",
	})
end

local function selected_chars()
	local words = vim.fn.wordcount()

	if not words.visual_chars then return "" end

	return table.concat({
		"%#StatuslineBufferInfoSCharIcon#",
		"󰘎 ",
		"%#StatuslineBufferInfoLine#",
		words.visual_chars,
		" ",
	})
end

return function()
	return table.concat({
		selected_lines(),
		selected_chars(),
		"%#StatuslineBufferInfoIcon#",
		"󰦨 ",
		"%#StatuslineBufferInfoLine#",
		"%L",
	})
end
