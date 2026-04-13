local plugins = { "lua/snacks", "lua/tokyonight" }
local library = { vim.env.VIMRUNTIME }

for _, v in ipairs(plugins) do
	local path = vim.api.nvim_get_runtime_file(v, false)[1]
	path = string.sub(path, 1, #path - #v) .. "lua"
	table.insert(library, path)
end

return {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.json"))
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
