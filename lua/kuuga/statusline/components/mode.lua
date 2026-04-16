local function get_mode(mode_code)
	local mode_map = {
		["n"] = "NORMAL",
		["no"] = "O-PENDING",
		["nov"] = "O-PENDING",
		["noV"] = "O-PENDING",
		["no\22"] = "O-PENDING",
		["niI"] = "NORMAL",
		["niR"] = "NORMAL",
		["niV"] = "NORMAL",
		["nt"] = "NORMAL",
		["ntT"] = "NORMAL",
		["v"] = "VISUAL",
		["vs"] = "VISUAL",
		["V"] = "V-LINE",
		["Vs"] = "V-LINE",
		["\22"] = "V-BLOCK",
		["\22s"] = "V-BLOCK",
		["s"] = "SELECT",
		["S"] = "S-LINE",
		["\19"] = "S-BLOCK",
		["i"] = "INSERT",
		["ic"] = "INSERT",
		["ix"] = "INSERT",
		["R"] = "REPLACE",
		["Rc"] = "REPLACE",
		["Rx"] = "REPLACE",
		["Rv"] = "V-REPLACE",
		["Rvc"] = "V-REPLACE",
		["Rvx"] = "V-REPLACE",
		["c"] = "COMMAND",
		["cv"] = "EX",
		["ce"] = "EX",
		["r"] = "REPLACE",
		["rm"] = "MORE",
		["r?"] = "CONFIRM",
		["!"] = "SHELL",
		["t"] = "TERMINAL",
	}

	if mode_map[mode_code] then return mode_map[mode_code] end

	return mode_code
end

local function get_mode_hl(mode_code)
	local mode_hls = {
		["n"] = "Normal",
		["no"] = "Normal",
		["nov"] = "Normal",
		["noV"] = "Normal",
		["no\22"] = "Normal",
		["niI"] = "Normal",
		["niR"] = "Normal",
		["niV"] = "Normal",
		["nt"] = "Normal",
		["ntT"] = "Normal",
		["v"] = "Visual",
		["vs"] = "Visual",
		["V"] = "Visual",
		["Vs"] = "Visual",
		["\22"] = "Visual",
		["\22s"] = "Visual",
		["s"] = "Visual",
		["S"] = "Visual",
		["\19"] = "Visual",
		["i"] = "Insert",
		["ic"] = "Insert",
		["ix"] = "Insert",
		["R"] = "Replace",
		["Rc"] = "Replace",
		["Rx"] = "Replace",
		["Rv"] = "Replace",
		["Rvc"] = "Replace",
		["Rvx"] = "Replace",
		["c"] = "Command",
		["cv"] = "Command",
		["ce"] = "Command",
		["r"] = "Command",
		["rm"] = "Command",
		["r?"] = "Command",
		["!"] = "Command",
		["t"] = "Terminal",
	}

	if mode_hls[mode_code] then return "%#StatusLineMode" .. mode_hls[mode_code] .. "#" end

	return "%#StatusLineModeNormal#"
end

return function(_)
	local mode_code = vim.api.nvim_get_mode().mode

	return table.concat({
		get_mode_hl(mode_code),
		get_mode(mode_code),
	})
end
