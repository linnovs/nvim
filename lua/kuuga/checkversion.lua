local version = require("vim.version")
local minimal_version = "^0.12"

if not version.range(minimal_version):has(version()) then
	vim.api.nvim_echo({
		{
			"Kuuga requires Neovim " .. minimal_version .. " or higher. Please update your Neovim installation.",
			"WarningMsg",
		},
		{
			"Press ENTER to exit.",
			"MoreMsg",
		},
	}, true, {})
	vim.fn.getchar()
	vim.cmd.quit()
end
