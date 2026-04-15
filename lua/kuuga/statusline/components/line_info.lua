return function()
	return table.concat({
		"%#StatusLineLineInfoIcon#",
		" ",
		"%#StatusLineLineInfoLine#",
		"%l:%c",
	})
end
