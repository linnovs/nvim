---@diagnostic disable: need-check-nil
local M = {}

local function version_check()
	local version = vim.version
	local expected_version = version.parse("0.10.0") or { 0, 0, 0 }

	if version.cmp(expected_version, version()) == -1 then
		vim.api.nvim_echo({
			{
				"Neovim version required to be at least 0.10\n",
				"WarningMsg",
			},
			{ "Press any key to exit", "MoreMsg" },
		}, true, {})
		vim.fn.getchar()
		vim.cmd([[quit]])
	end
end

M.did_init = false
function M.init()
	if M.did_init then
		return
	end

	version_check()

	vim.g.mapleader = " "

	M.delay_notifications()

	-- load all options before lazy.nvim run
	require("kuuga.config.options")
	require("kuuga.config.filetypes")
	require("kuuga.config.plugin")

	M.did_init = true
end

function M.setup()
	M.init()

	if vim.fn.argc(-1) == 0 then
		vim.api.nvim_create_autocmd("User", {
			group = vim.api.nvim_create_augroup("Kuuga", { clear = true }),
			pattern = "VeryLazy",
			callback = function()
				require("kuuga.config.autocmds")
				require("kuuga.config.mappings")
			end,
		})
	else
		require("kuuga.config.autocmds")
		require("kuuga.config.mappings")
	end

	vim.cmd.colorscheme("catppuccin")

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

	local timer = vim.loop.new_timer()
	local check = vim.loop.new_check()

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
