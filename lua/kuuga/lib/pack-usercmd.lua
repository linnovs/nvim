local M = {}

---@param name string
---@param command fun()
function M.user_command(name, command)
	return vim.api.nvim_create_user_command(name, function(cmd_args)
		pcall(vim.api.nvim_del_user_command, name)

		command()

		pcall(vim.api.nvim_cmd, {
			cmd = name,
			args = cmd_args.fargs,
		}, {})
	end, { nargs = "*" })
end

return M
