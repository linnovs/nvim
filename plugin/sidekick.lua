local gh = require("kuuga.helper.gh")
local keymap = require("kuuga.lib.keymap")

vim.schedule(function()
	vim.pack.add({ { src = gh("folke/sidekick.nvim"), version = vim.version.range("*") } })
	vim.g.sidekick_nes = false
	require("sidekick").setup({
		cli = { mux = { enabled = true }, win = { bo = { scrollback = 0 }, layout = "right" } },
	})

	keymap(
		"n",
		"<Leader>aa",
		function() require("sidekick.cli").toggle({ filter = { installed = true }, focus = true }) end,
		"Toggle sidekick (installed tools)"
	)
	keymap({ "n", "x" }, "<Leader>at", function() require("sidekick.cli").send({ msg = "{this}" }) end, "Send this")
	keymap("n", "<Leader>af", function() require("sidekick.cli").send({ msg = "{file}" }) end, "Send file")
	keymap(
		"x",
		"<Leader>av",
		function() require("sidekick.cli").send({ msg = "{selection}" }) end,
		"Send Visual Selection"
	)
	keymap({ "n", "x" }, "<Leader>ap", function() require("sidekick.cli").prompt() end, "Sidekick Select Prompt")
end)
