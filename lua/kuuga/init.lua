---@diagnostic disable: need-check-nil
local M = {}

---@class KuugaOptions
---@field public version string
---@field public colorscheme string

---@param opts KuugaOptions
local function version_check(opts)
	local version = vim.version
	local expected_version = version.parse(opts.version) or { 0, 0, 0 }

	if version.lt(version(), expected_version) then
		vim.api.nvim_echo({
			{
				"Neovim version required to be at least " .. opts.version .. " \n",
				"WarningMsg",
			},
			{ "Press any key to exit", "MoreMsg" },
		}, true, {})
		vim.fn.getchar()
		vim.cmd([[quit]])
	end
end

--@param opts KuugaOptions
local function set_colorscheme(opts)
	if opts.colorscheme then
		vim.cmd.colorscheme(opts.colorscheme)
	else
		vim.api.nvim_echo({
			{
				"missing colorscheme option in init.lua\n",
				"WarningMsg",
			},
			{ "Press any key to exit", "MoreMsg" },
		}, true, {})
		vim.fn.getchar()
		vim.cmd([[quit]])
	end
end

M.did_init = false
---@param opts KuugaOptions
function M.init(opts)
	if M.did_init then
		return
	end

	version_check(opts)
	M.delay_notifications()

	vim.g.mapleader = " "
	-- load all options before lazy.nvim run
	require("kuuga.config.options")
	require("kuuga.config.filetypes")
	require("kuuga.config.plugin") -- lazy.nvim
	set_colorscheme(opts)

	M.did_init = true
end

---@param opts KuugaOptions
function M.setup(opts)
	M.init(opts)

	vim.api.nvim_create_autocmd("User", {
		group = vim.api.nvim_create_augroup("Kuuga", { clear = true }),
		pattern = "VeryLazy",
		callback = function()
			require("kuuga.config.autocmds")
			require("kuuga.config.mappings")
		end,
	})

	-- neovide config
	if vim.g.neovide then
		require("kuuga.config.neovide")
	end
end

-- this function is from https://github.com/LazyVim/LazyVim/blob/97996faf75c33a9487653be7dd59ecd39c028e52/lua/lazyvim/util/init.lua#L144
function M.delay_notifications()
	local notifs = {}
	local function temp(...)
		table.insert(notifs, vim.F.pack_len(...))
	end

	local orig = vim.notify
	vim.notify = temp

	local timer = vim.uv.new_timer()
	local check = assert(vim.uv.new_check())

	local replay = function()
		timer:stop()
		check:stop()
		if vim.notiy == temp then
			vim.notify = orig -- put it back
		end
		vim.schedule(function()
			for _, n in ipairs(notifs) do
				orig(vim.F.unpack_len(n))
			end
		end)
	end

	-- wait until vim.notify is replaced
	check:start(function()
		if vim.notify ~= temp then
			replay()
		end
	end)

	-- something is wrong if after 500ms
	timer:start(500, 0, replay)
end

return M
