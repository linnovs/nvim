local dashboard = require("kuuga.lib.dashboard")

return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@module "snacks"
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			indent = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			styles = {
				notification = {
					wo = { wrap = true, winblend = 0 },
				},
				lazygit = {
					keys = {
						-- stylua: ignore
						reset_ob = { "[", "[", mode = "t" },
					},
				},
				terminal = {
					keys = {
						-- stylua: ignore start
						toggle    = { "<Leader>tt", "<Cmd>close<CR>", mode = "t" },
						win_up    = { "<Leader>wk", "<Cmd>wincmd k<CR>", desc = "Moves to window above", mode = "t" },
						win_down  = { "<Leader>wj", "<Cmd>wincmd j<CR>", desc = "Moves to window below", mode = "t" },
						win_right = { "<Leader>wh", "<Cmd>wincmd h<CR>", desc = "Moves to window right", mode = "t" },
						win_left  = { "<Leader>wl", "<Cmd>wincmd l<CR>", desc = "Moves to window left", mode = "t" },
						-- stylua: ignore end
					},
				},
			},
			dashboard = dashboard,
		},
		keys = {
			-- stylua: ignore start
			{ "<leader>un",  function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications", },
			{ "<leader>bd",  function() Snacks.bufdelete() end, desc = "Delete Buffer", },
			{ "<leader>fbd", function() Snacks.bufdelete({force = true}) end, desc = "Delete Buffer", },
			{ "<leader>gst", function() Snacks.lazygit() end, desc = "Lazygit", },
			{ "<leader>gB",  function() Snacks.gitbrowse() end, desc = "Git Browse", },
			{ "<leader>gfl", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History", },
			{ "<leader>gl",  function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)", },
			{ "<leader>tt",  function() Snacks.terminal(nil, { win = { height = 0.3 } }) end, desc = "Toggle terminal", },
			{ "]]",          function() Snacks.words.jump(vim.v.count1) end, desc = "Next reference", },
			{ "[[",          function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev reference", },
			-- stylua: ignore end
			{
				"<leader>N",
				desc = "Neovim News",
				function()
					Snacks.win({
						file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
						width = 0.6,
						height = 0.6,
						wo = {
							winblend = 5,
							spell = false,
							wrap = false,
							signcolumn = "yes",
							statuscolumn = " ",
							conceallevel = 3,
						},
					})
				end,
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- add global functions for debugging (lazy-loaded)
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end

					-- override print to use snacks for `:=` command
					vim.print = _G.dd

					-- toggle mappings
					Snacks.toggle
						.option("spell", {
							name = "Spelling",
							map = function(mode, lhs, rhs, opts)
								vim.keymap.set(mode, lhs, function()
									rhs()
									vim.api.nvim_exec_autocmds("User", {
										pattern = "QoLToggleSpelling",
									})
								end, opts)
							end,
						})
						:map("yos")
					Snacks.toggle.option("cursorcolumn", { name = "Cursor column" }):map("yoc")
					Snacks.toggle.option("wrap", { name = "Line wrap" }):map("yow")
					Snacks.toggle.inlay_hints():map("yoih")
				end,
			})
		end,
	},
}
