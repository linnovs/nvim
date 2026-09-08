vim.filetype.add({
	extension = {
		base = "yaml",
		yaml = function()
			local is_ansible = vim.fs.root(0, { "ansible.cfg", ".ansible-lint" })

			if is_ansible then return "yaml.ansible" end

			return "yaml"
		end,
	},
	filename = {
		PKGBUILD = "sh.pkgbuild",
	},
	pattern = {
		["compose%.ya?ml"] = "yaml.docker-compose",
	},
})
