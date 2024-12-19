local M = {}

M.diagnostics = { Error = " ", Warn = " ", Hint = " ", Info = " " }
M.kind_icons = {
	Text = "󰉿",
	Method = "",
	Function = "󰊕",
	Constructor = "󰒓",

	Field = "",
	Variable = "",
	Property = "",

	Class = "",
	Interface = "",
	Struct = "",
	Module = "",

	Unit = "",
	Value = "",
	Enum = "",
	EnumMember = "",

	Keyword = "",
	Constant = "",

	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "󰉋",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

return M
