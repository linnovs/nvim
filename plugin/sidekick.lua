local keymap = require("kuuga.lib.keymap")

vim.schedule(function()
	vim.pack.add({ { src = "https://github.com/folke/sidekick.nvim", version = vim.version.range("*") } })
	require("sidekick").setup({
		cli = { mux = { enabled = true }, win = { bo = { scrollback = 0 }, layout = "float" } },
	})

	keymap("n", "<Tab>", function()
		if not require("sidekick").nes_jump_or_apply() then return "<Tab>" end
	end, "Goto/Apply Next Editor Suggestion", { expr = true })
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
