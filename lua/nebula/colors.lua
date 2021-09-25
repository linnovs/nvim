local M = {}

M.basic = {
	red = "#f7768e", -- 	This keyword, HTML elements, Regex group symbol, CSS units, Terminal Red
	orange = "#ff9e64", -- 	Number and Boolean constants, Language support constants
	yellow = "#e0af68", -- 	Function parameters, Regex character sets, Terminal Yellow
	dark_green = "#9ece6a", -- 	Strings, CSS class names
	green = "#73daca", -- 	Object literal keys, Markdown links, Terminal Green
	light_green = "#b4f9f8", -- 	Regex literal strings
	dark_cyan = "#2ac3de", -- 	Language support functions, CSS HTML elements
	cyan = "#7dcfff", -- 	Object properties, Regex quantifiers and flags, Markdown headings, Terminal Cyan, Markdown code, Import/export keywords
	blue = "#7aa2f7", -- 	Function names, CSS property names, Terminal Blue
	magenta = "#bb9af7", -- 	Control Keywords, Storage Types, Regex symbols and operators, HTML Attributes, Terminal Magenta
	white = "#c0caf5", -- 	Variables, Class names, Terminal White
	ligth_gray = "#9aa5ce", -- 	Markdown Text, HTML Text
	light_yellow = "#cfc9c2", -- 	Parameters inside functions (semantic highlighting only)
	gray = "#565f89", -- 	Comments
	black = "#414868", -- 	Terminal Black
	fg = "#a9b1d6", -- 	Editor Foreground
	bg = "#24283b", -- 	Editor Background (Storm)
	alt_bg = "#1f2335",
	bg_highlight = "#292e42",
}

M.git = {
	added = "#449dab",
	modified = "#6183bb",
	removed = "#914c54",
}

M.lsp = {
	error = "#db4b4b",
	warning = "#e0af68",
	information = "#0db9d7",
	hint = "#10b981",
}

return M
