local vimp = require("vimp")

vimp.map_command("Reload", function()
	vimp.unmap_all()

	for key, _ in pairs(package.loaded) do
		if key:match("^kuuga") then
			package.loaded[key] = nil
		end
	end

	vim.cmd("silent wa")
	dofile(vim.env.MYVIMRC)
	vim.cmd("PackerCompile")
	vim.notify("Reloaded config")
end)
