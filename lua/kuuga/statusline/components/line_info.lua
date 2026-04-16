return function(_)
	return table.concat({
		"%#StatusLineLineInfoIcon#",
		" ",
		"%#StatusLineLineInfoLine#",
		"%l:%c",
	})
end
