local library = vim.tbl_filter(
	function(d) return d:match(vim.fn.stdpath("data") .. "/site/pack/core/opt") or d:match(vim.env.VIMRUNTIME) end,
	vim.api.nvim_get_runtime_file("", true)
)

return {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT",
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
					"${3rd}/luv/library",
				},
			},
			workspace = {
				library = library,
			},
		})
	end,
	settings = {
		Lua = {
			hint = {
				enable = true,
			},
			format = {
				enable = false,
			},
			workspace = {
				checkThirdParty = false,
				ignoreSubmodules = true,
			},
			completion = {
				callSnippet = "Replace",
			},
		},
	},
}
