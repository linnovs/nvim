local function selected_lines()
	local lines = math.abs(vim.fn.line("v") - vim.fn.line(".")) + 1

	if lines <= 1 then return "" end

	return table.concat({
		"%#StatuslineLineInfoSLineIcon#",
		" ",
		"%#StatuslineLineInfoLine#",
		lines,
		" ",
	})
end

local function selected_chars()
	local words = vim.fn.wordcount()

	if not words.visual_chars then return "" end

	return table.concat({
		"%#StatuslineLineInfoSCharIcon#",
		"󰘎 ",
		"%#StatuslineLineInfoLine#",
		words.visual_chars,
		" ",
	})
end

return function()
	return table.concat({
		selected_lines(),
		selected_chars(),
		"%#StatuslineLineInfoIcon#",
		" ",
		"%#StatuslineLineInfoLine#",
		"%l:%c",
	})
end
