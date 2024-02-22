return {
	"epwalsh/obsidian.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = {
		"BufReadPre " .. vim.fn.expand("~") .. "/Documents/Obsidian Vault/**.md",
		"BufNewFile " .. vim.fn.expand("~") .. "/Documents/Obsidian Vault/**.md",
	},
	keys = {
		{
			"<leader>oo",
			"<CMD>ObsidianQuickSwitch<CR>",
			desc = "Obsidian Quick Switch",
		},
		{
			"<leader>os",
			"<CMD>ObsidianSearch<CR>",
			desc = "Obsidian Search",
		},
		{
			"<leader>on",
			"<CMD>ObsidianNew<CR>",
			desc = "Obsidian New Note",
		},
		{
			"<leader>oa",
			"<CMD>ObsidianOpen<CR>",
			desc = "Open Obsidian App",
		},
		{
			"<leader>ot",
			"<CMD>ObsidianToday<CR>",
			desc = "Create Obsidian Today Note",
		},
		{
			"<leader>oy",
			"<CMD>ObsidianToday<CR>",
			desc = "Create/Open Obsidian Yesterday Note",
		},
	},
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/Documents/Obsidian Vault",
			},
		},
		notes_subdir = "notes",
		daily_notes = {
			folder = "notes/dailies",
		},
		completion = {
			nvim_cmp = true,
			min_chars = 2,
		},
		mapping = {
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrouhg()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			["<LEADER>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
		},
		new_notes_location = "current_dir",
		note_id_func = function(title)
			-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
			-- In this case a note with the title 'My new note' will be given an ID that looks
			-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
			local suffix = ""
			if title ~= nil then
				-- If title is given, transform it into valid file name.
				suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				-- If title is nil, just add 4 random uppercase letters to the suffix.
				for _ = 1, 4 do
					suffix = suffix .. string.char(math.random(65, 90))
				end
			end
			return tostring(os.time()) .. "-" .. suffix
		end,
		wiki_link_func = function(opts)
			if opts.id == nil then
				return string.format("[[%s]]", opts.label)
			elseif opts.label ~= opts.id then
				return string.format("[[%s|%s]]", opts.id, opts.label)
			else
				return string.format("[[%s]]", opts.id)
			end
		end,
		markdown_link_func = function(opts)
			return string.format("[%s](%s)", opts.label, opts.path)
		end,
		preferred_link_style = "wiki",
		image_name_func = function()
			-- Prefix image names with timestamp.
			return string.format("%s-", os.time())
		end,
		disable_frontmatter = false,
		note_frontmatter_func = function(note)
			-- This is equivalent to the default frontmatter function.
			local out = { id = note.id, aliases = note.aliases, tags = note.tags }
			-- `note.metadata` contains any manually added fields in the frontmatter.
			-- So here we just make sure those fields are kept in the frontmatter.
			if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
				for k, v in pairs(note.metadata) do
					out[k] = v
				end
			end
			return out
		end,
		use_advanced_uri = true,
		open_app_foreground = true,
		pick = {
			name = "telescope.nvim",
			mapping = {
				new = "<C-x>",
				insert_link = "<C-l>",
			},
		},
		sort_by = "modified",
		sort_reversed = true,
		open_note_in = "current",
		ui = {
			enable = true,
			update_debounce = 200,
			checkboxes = {
				-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
				[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
				["x"] = { char = "", hl_group = "ObsidianDone" },
				[">"] = { char = "", hl_group = "ObsidianRightArrow" },
				["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
			},
			bullets = { char = "•", hl_group = "ObsidianBullet" },
			external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
			reference_text = { hl_group = "ObsidianRefText" },
			highlight_text = { hl_group = "ObsidianHighlightText" },
			tags = { hl_group = "ObsidianTag" },
			hl_groups = {
				-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
				ObsidianTodo = { bold = true, fg = "#f78c6c" },
				ObsidianDone = { bold = true, fg = "#89ddff" },
				ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
				ObsidianTilde = { bold = true, fg = "#ff5370" },
				ObsidianBullet = { bold = true, fg = "#89ddff" },
				ObsidianRefText = { underline = true, fg = "#c792ea" },
				ObsidianExtLinkIcon = { fg = "#c792ea" },
				ObsidianTag = { italic = true, fg = "#89ddff" },
				ObsidianHighlightText = { bg = "#75662e" },
			},
		},
		attachments = {
			img_folder = "assets/imgs",
			-- A function that determines the text to insert in the note when pasting an image.
			-- It takes two arguments, the `obsidian.Client` and a plenary `Path` to the image file.
			-- This is the default implementation.
			---@param client obsidian.Client
			---@param path Path the absolute path to the image file
			---@return string
			img_text_func = function(client, path)
				local link_path
				local vault_relative_path = client:vault_relative_path(path)
				if vault_relative_path ~= nil then
					-- Use relative path if the image is saved in the vault dir.
					link_path = vault_relative_path
				else
					-- Otherwise use the absolute path.
					link_path = tostring(path)
				end
				local display_name = vim.fs.basename(link_path)
				return string.format("![%s](%s)", display_name, link_path)
			end,
		},
		yaml_parser = "native",
	},
	config = function(_, opts)
		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			pattern = vim.fn.expand("~/Documents/Obsidian Vault/**.md"),
			callback = function()
				vim.opt.conceallevel = 2
			end,
		})

		require("obsidian").setup(opts)
	end,
}
