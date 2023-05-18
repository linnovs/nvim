local M = {}

function M.setup(opts)
	if vim.fn.argc(-1) == 0 then
		vim.api.nvim_create_autocmd("User", {
			group = vim.api.nvim_create_augroup("Kuuga", { clear = true }),
			pattern = "VeryLazy",
			callback = function()
				require("kuuga.autocmds")
				require("kuuga.mappings")
			end,
		})
	else
		require("kuuga.autocmds")
		require("kuuga.mappings")
	end

	if opts.colorscheme ~= nil then
		vim.cmd.colorscheme(opts.colorscheme)
	end

	-- neovide config
	vim.g.neovide_no_idle = true
end

M.did_init = false
function M.init()
	if not M.did_init then
		M.delay_notifications()

		-- load all options before lazy.nvim run
		require("kuuga.options")

		M.did_init = true
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
