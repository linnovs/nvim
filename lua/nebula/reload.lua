local vimp = require("vimp")

vimp.map_command("Reload", function()
	vimp.unmap_all()

	for key, _ in pairs(package.loaded) do
		if key == "nebula" or key:sub(1, #"nebula.") == "nebula." or key == "plugins" then
			package.loaded[key] = nil
		end
	end

	vim.cmd("silent wa")

	dofile(vim.fn.stdpath("config") .. "/init.lua")
	vim.cmd("PackerSync")

	print("Reloaded config")
end)
