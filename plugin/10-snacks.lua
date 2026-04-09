---@diagnostic disable: duplicate-set-field
local gh = require("kuuga.lib.pack-source.gh")
vim.pack.add({ { src = gh("folke/snacks.nvim"), version = vim.version.range("*") } })
vim.schedule(function()
	_G.dd = function(...) Snacks.debug.inspect(...) end
	_G.bt = function() Snacks.debug.backtrace() end
	vim.print = _G.dd

	Snacks.toggle.option("cursorcolumn", { name = "Cursor column" }):map("yoc")
	Snacks.toggle.option("wrap", { name = "Wrap lines" }):map("yow")
	Snacks.toggle.inlay_hints():map("yoih")

	vim.api.nvim_create_autocmd("User", {
		pattern = "OilActionPost",
		callback = function(ev)
			if ev.data.actions[1].type == "move" then
				Snacks.rename.on_rename_file(ev.data.actions[1].src_url, ev.data.actions[1].dest_url)
			end
		end,
	})
end)

local keymaps = {
	{ "<Leader>z", function() Snacks.zen() end, "Toggle Zen mode" },
	{ "<Leader>Z", function() Snacks.zen.zoom() end, "Toggle Zen zoom" },
	{ "<Leader>un", function() Snacks.notifier.hide() end, "Dismiss All notifications" },
	{ "<Leader>.", function() Snacks.scratch() end, "Toggle scratch buffer" },
	{ "<Leader>S", function() Snacks.scratch.select() end, "Select scratch buffer" },
	{ "<Leader>n", function() Snacks.notifier.show_history() end, "Notifications history" },
	{ "<Leader>bd", function() Snacks.bufdelete() end, "Delete buffer" },
	{ "<Leader>fbd", function() Snacks.bufdelete({ force = true }) end, "Force delete buffer" },
	{ "<Leader>gst", function() Snacks.lazygit() end, "Toggle Lazygit" },
	{ "<Leader>gB", function() Snacks.gitbrowse() end, "Git Browse" },
	{ "<Leader>glf", function() Snacks.lazygit.log_file() end, "Lazygit Current file history" },
	{ "<Leader>gl", function() Snacks.lazygit.log() end, "Lazygit log (CWD)" },
	{ "<Leader>gp", function() Snacks.picker.gh_pr() end, "GitHub Pull Requests (Open)" },
	{ "<Leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, "GitHub Pull Requests (All)" },
	{ "<Leader>tt", function() Snacks.terminal(nil, { win = { height = 0.3 } }) end, "Toggle terminal" },
	{ "]]", function() Snacks.words.jump(vim.v.count1) end, "Next reference" },
	{ "[[", function() Snacks.words.jump(-vim.v.count1) end, "Previous reference" },
	{ "<Leader><Leader>", function() Snacks.picker.files() end, "Find files" },
	{ "<leader>fg", function() Snacks.picker.grep() end, "Grep files" },
	{ "<Leader>fb", function() Snacks.picker.buffers() end, "Find buffers" },
	{ "<Leader>fh", function() Snacks.picker.help() end, "Find help pages" },
	{ "<Leader>fm", function() Snacks.picker.man() end, "Find man pages" },
	{ "<Leader>fe", function() Snacks.explorer() end, "File explorer" },
	{
		"<Leader>N",
		function()
			Snacks.win({
				file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
				width = 0.6,
				height = 0.6,
				wo = {
					winblend = 0,
					spell = false,
					wrap = false,
					signcolumn = "yes",
					statuscolumn = " ",
					conceallevel = 3,
				},
			})
		end,
		"Neovim news",
	},
}

for _, km in ipairs(keymaps) do
	require("kuuga.lib.keymap")("n", km[1], km[2], km[3])
end

require("snacks").setup({
	bigfile = { enabled = true },
	indent = { enabled = true, chunk = { enabled = true } },
	image = {
		enabled = true,
		resolve = function(path, src)
			local status, module = pcall(require, "obsidian.api")
			if not status then return nil end

			if module.path_is_note(path) then return module.resolve_image_path(src) end

			return nil
		end,
	},
	notifier = { enabled = true },
	quickfile = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
	picker = {
		actions = {
			sidekick_send = function(...)
				local status, module = pcall(require, "sidekick.cli.picker.snacks")

				if status then module.send(...) end
			end,
		},
		formatters = {
			file = {
				filename_first = true,
			},
		},
		win = {
			input = {
				keys = {
					["<a-a>"] = {
						"sidekick_send",
						mode = { "n", "i" },
					},
				},
			},
		},
	},
	gh = {},
	words = { enabled = true },
	styles = {
		lazygit = {
			keys = {
				reset_ob = { "[", "[", mode = "t", expr = true },
			},
		},
		terminal = {
			keys = {
				toggle = { "<Leader>tt", "<Cmd>close<CR>", mode = "t", expr = true },
			},
		},
		notification_history = {
			wo = { wrap = true, linebreak = true },
		},
	},
	dashboard = require("kuuga.lib.dashboard"),
})
