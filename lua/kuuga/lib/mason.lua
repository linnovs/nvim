local M = {}

M.last_install = 0

local mason_exist, registry = pcall(require, "mason-registry")

---@param server_name string
---@param callback fun(string, vim.log.levels)
local function install_server(server_name, callback)
	if not registry.has_package(server_name) then
		callback("Server " .. server_name .. " not exist", vim.log.levels.WARN)
		return
	end

	local pkg = registry.get_package(server_name)
	local is_installed = pkg:is_installed()
	local success_msg = (is_installed and "Updated " or "Installed ") .. server_name
	local failed_msg = (is_installed and "Update " or "Install ") .. server_name .. " failed"

	pkg:install({}, function(success, data)
		local msg = success and success_msg or failed_msg .. "\nError: " .. data
		local lvl = success and vim.log.levels.INFO or vim.log.levels.ERROR

		callback(msg, lvl)
	end)
end

---@param msg string
---@param lvl vim.log.levels
---@param opts? table
local function notify(msg, lvl, opts)
	opts = opts or {}
	local notify_fn = vim.in_fast_event() and vim.schedule_wrap(vim.notify) or vim.notify
	msg = vim.trim(msg)
	opts.title = opts.title or "Mason"
	return notify_fn(msg, lvl, opts)
end

function M.install(servers)
	if not mason_exist then return end

	if vim.uv.gettimeofday() - M.last_install < 6 * 60 then return end

	for _, server in ipairs(servers) do
		install_server(server, function(msg, lvl) notify(msg, lvl) end)
	end

	M.last_install = vim.uv.gettimeofday()
end

return M
