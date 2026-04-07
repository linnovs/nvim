vim.schedule(function()
	vim.pack.add({ { src = "https://github.com/folke/sidekick.nvim", version = vim.version.range("*") } })
	require("sidekick").setup({
		cli = { mux = { enabled = true }, win = { bo = { scrollback = 0 }, layout = "float" } },
	})

	local keys = {
		{
			"<tab>",
			function()
				if not require("sidekick").nes_jump_or_apply() then
					return "<tab>"
				end
			end,
			expr = true,
			desc = "Goto/Apply Next Editor Suggestion",
		},
		{
			"<leader>aa",
			function()
				require("sidekick.cli").toggle({ filter = { installed = true }, focus = true })
			end,
			desc = "Toggle sidekick (installed tools)",
		},
		{
			"<leader>at",
			function()
				require("sidekick.cli").send({ msg = "{this}" })
			end,
			mode = { "x", "n" },
			desc = "Send this",
		},
		{
			"<leader>af",
			function()
				require("sidekick.cli").send({ msg = "{file}" })
			end,
			desc = "Send file",
		},
		{
			"<leader>av",
			function()
				require("sidekick.cli").send({ msg = "{selection}" })
			end,
			mode = { "x" },
			desc = "Send Visual Selection",
		},
		{
			"<leader>ap",
			function()
				require("sidekick.cli").prompt()
			end,
			mode = { "n", "x" },
			desc = "Sidekick Select Prompt",
		},
	}

	for _, part in ipairs(keys) do
		require("kuuga.lib.keymap")(part.mode or "n", part[1], part[2], part.decs or "")
	end
end)
