-- from https://github.com/LazyVim/LazyVim/blob/83d90f339defdb109a6ede333865a66ffc7ef6aa/lua/lazyvim/util/init.lua#L144
-- delay notify until vim.notify is available or after 500ms
local notifs = {}
local function temp(...)
	table.insert(notifs, vim.F.pack_len(...))
end

local orig = vim.notify
vim.notify = temp

local timer = vim.uv.new_timer()
local check = assert(vim.uv.new_check())

if timer == nil or check == nil then
	-- if uv is not available, just put back the original notify and return
	vim.notify = orig
	return
end

local replay = function()
	timer:stop()
	check:stop()
	if vim.notify == temp then
		vim.notify = orig -- put back the original notify if needed
	end
	vim.schedule(function()
		---@diagnostic disable-next-line: no-unknown
		for _, notif in ipairs(notifs) do
			vim.notify(vim.F.unpack_len(notif))
		end
	end)
end

-- wait till vim.notify has been replaced
check:start(function()
	if vim.notify ~= temp then
		replay()
	end
end)
-- or if it took more than 500ms, then something went wrong
timer:start(500, 0, replay)
