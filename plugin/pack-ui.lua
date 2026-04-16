local api = vim.api
local plugname = "pack-ui"
local ns = api.nvim_create_namespace(plugname)

local hl_links = {
	PackUIHighlight = "Special",
	PackUIHeader = "Bold",
	PackUIDimmed = "Comment",
	PackUILoaded = "OkMsg",
	PackUINotLoaded = "Comment",
	PackUIDetail = "Bold",
}

for hl_group, target in pairs(hl_links) do
	api.nvim_set_hl(0, hl_group, { link = target, default = true })
end

---@alias LineToPlugin { [integer]: string }
---@alias PluginLines { [string]: integer }

local state = {
	bufnr = nil, ---@type integer
	winid = nil, ---@type integer
	lines_map = {}, ---@type LineToPlugin
	plugins_map = {}, ---@type PluginLines
	expanded = {}, ---@type { [string]: boolean }
	show_help = false, ---@type boolean
}

---@param a vim.pack.PlugData
---@param b vim.pack.PlugData
local function sort_plug(a, b) return a.spec.name < b.spec.name end

---@param text string
---@param width integer
---@param fill? string
local function centerAlign(text, width, fill)
	fill = fill or " "
	local n = width - #text
	if n <= 0 then return text end
	local left = math.floor(n / 2)
	local right = n - left
	return string.rep(fill, left) .. text .. string.rep(fill, right)
end

---@type { [string]: string }
local tag_cache = setmetatable({}, { __mode = "k" })

---@param p vim.pack.PlugData
---@return string
local function get_plug_version(p)
	local v = p.spec.version
	if v == nil then
		if p.rev then return p.rev:sub(1, 7) end
		return ""
	end
	if type(v) == "string" then return v end
	if tag_cache[p.path] ~= nil then return tag_cache[p.path] end
	local result = vim.system(
		{ "git", "describe", "--tags", "--exact-match", "--match", "v*", "--match", "[[:digit:]]*", "HEAD" },
		{ cwd = p.path, text = true }
	):wait()
	if result.code == 0 then
		local tag = vim.trim(result.stdout)
		tag_cache[p.path] = tag
		return tag
	else
		vim.print(p.spec.name, result)
	end
	return ""
end

---@alias HighlightList { line: integer, col: integer, end_col: integer, hl_group: string|integer }[]

---@return string[], HighlightList
local function build_contents()
	local plugins = vim.pack.get(nil, { info = false })

	local loaded = {} ---@type vim.pack.PlugData[]
	local not_loaded = {} ---@type vim.pack.PlugData[]
	for _, plug in ipairs(plugins) do
		if plug.active then
			table.insert(loaded, plug)
		else
			table.insert(not_loaded, plug)
		end
	end

	table.sort(loaded, sort_plug)
	table.sort(not_loaded, sort_plug)

	local lines = {} ---@type string[]
	local hls = {} ---@type HighlightList
	local lines_map = {} ---@type LineToPlugin
	local plugins_map = {} ---@type PluginLines

	local function add(text, hl)
		local lnum = #lines
		lines[#lines + 1] = text
		if hl then table.insert(hls, { line = lnum, col = 0, end_col = #text, hl_group = hl }) end
	end

	local function add_hl(lnum, col_start, col_end, hl)
		table.insert(hls, { line = lnum, col = col_start, end_col = col_end, hl_group = hl })
	end

	local helpTxt = centerAlign("press g? for help", api.nvim_win_get_width(state.winid))
	local helpTxtSrt, helpTxtE = string.find(helpTxt, "g%?")

	add(helpTxt)
	add_hl(0, helpTxtSrt - 1, helpTxtE, "PackUIHighlight")
	add("")
	add("  Total:", "PackUIHeader")
	add(string.format("  %d plugins", #plugins), "PackUIDimmed")

	if state.show_help then
		add("")
		add("  Keymaps:", "PackUIHeader")
		local keymaps = {
			{ "]]", "Next plugin" },
			{ "[[", "Previous plugin" },
			{ "<CR>", "Toggle plugin detail" },
			{ "u", "Update plugin under cursor" },
			{ "U", "Update all plugins" },
			{ "x", "Delete plugin under cursor" },
		}

		local max_desc_len = 0
		for _, keymap in ipairs(keymaps) do
			max_desc_len = math.max(max_desc_len, #keymap[2] + 1)
		end

		for _, keymap in ipairs(keymaps) do
			add(string.format("  % -" .. max_desc_len .. "s%s", keymap[2], keymap[1]))
			local lnum = #lines - 1
			add_hl(lnum, 2, 2 + max_desc_len, "PackUIDimmed")
			add_hl(lnum, 2 + max_desc_len, 2 + max_desc_len + #keymap[1], "PackUIHighlight")
		end
	end

	add("")
	add(string.format("  Loaded (%d)", #loaded), "PackUIHeader")

	local name_width = 0
	for _, p in ipairs(plugins) do
		name_width = math.max(name_width, #p.spec.name)
	end

	---@param p vim.pack.PlugData
	---@param icon string
	---@param hl_group string|integer
	local function render_plugin(p, icon, hl_group)
		local name = p.spec.name
		local line = string.format("    %s %s", icon, name)
		local cur_lnum = #lines
		local icon_size = #icon
		local icon_start = 3

		add(line)
		add_hl(cur_lnum, icon_start, icon_start + icon_size, hl_group)

		lines_map[cur_lnum + 1] = name
		plugins_map[name] = cur_lnum + 1

		if state.expanded[name] then
			local details = {
				string.format("      Path:    %s", p.path),
				string.format("      Source:  %s", p.spec.src),
			}

			local version = get_plug_version(p)
			if #version > 0 then table.insert(details, string.format("      Version: %s", version)) end
			if p.rev then table.insert(details, string.format("      Rev:     %s", p.rev)) end

			add("")
			for _, d in ipairs(details) do
				add(d)
				local lnum = #lines - 1
				add_hl(lnum, 0, 15, "PackUIDimmed")
				add_hl(lnum, 15, #d, "PackUIDetail")
			end
			add("")
		end
	end

	-- loaded
	for _, p in ipairs(loaded) do
		render_plugin(p, "", "PackUILoaded")
	end

	-- not_loaded
	if #not_loaded > 0 then
		add("")
		add(string.format("  Not Loaded (%d)", #not_loaded), "PackUIHeader")
		for _, p in ipairs(not_loaded) do
			render_plugin(p, "", "PackUINotLoaded")
		end
	end

	state.lines_map = lines_map
	state.plugins_map = plugins_map

	return lines, hls
end
local function render()
	if not state.bufnr or not api.nvim_buf_is_valid(state.bufnr) then return end

	local lines, hls = build_contents()

	vim.bo[state.bufnr].modifiable = true
	api.nvim_buf_set_lines(state.bufnr, 0, -1, false, lines)
	vim.bo[state.bufnr].modifiable = false
	vim.bo[state.bufnr].modified = false

	-- apply highlights
	api.nvim_buf_clear_namespace(state.bufnr, ns, 0, -1)
	for _, hl in ipairs(hls) do
		api.nvim_buf_set_extmark(state.bufnr, ns, hl.line, hl.col, {
			end_col = hl.end_col,
			hl_group = hl.hl_group,
		})
	end
end

---@param modes string|string[]
---@param lhs string
---@param rhs string|fun()
---@param desc string
---@param opts? vim.keymap.set.Opts
local function keymap(modes, lhs, rhs, desc, opts)
	opts = opts or {}
	opts = vim.tbl_extend("force", {
		buffer = state.bufnr,
		silent = true,
		nowait = true,
		desc = desc,
	}, opts)
	return vim.keymap.set(modes, lhs, rhs, opts)
end

local function plugin_at_cursor()
	if not state.winid or not api.nvim_win_is_valid(state.winid) then return nil end
	local row = api.nvim_win_get_cursor(state.winid)[1]
	return state.lines_map[row]
end

---@param msg string
---@param level vim.log.levels
local function notify(msg, level) return vim.notify(msg, level, { title = "vim.pack" }) end

---@param direction integer
local function jump_to_plugin(direction)
	if not state.winid or not api.nvim_win_is_valid(state.winid) then return end

	local curpos = api.nvim_win_get_cursor(state.winid)[1]

	local lines = vim.tbl_keys(state.lines_map)
	table.sort(lines)

	local start_index = direction > 0 and 1 or #lines
	local stop_index = direction > 0 and #lines or 1
	local step = direction > 0 and 1 or -1
	local should_wrap = true

	for i = start_index, stop_index, step do
		if (direction > 0 and curpos < lines[i]) or (direction < 0 and curpos > lines[i]) then
			api.nvim_win_set_cursor(state.winid, { lines[i], 8 })
			should_wrap = false
			break
		end
	end

	if should_wrap and #lines > 0 then
		api.nvim_win_set_cursor(state.winid, { lines[direction > 0 and 1 or #lines], 8 })
	end
end

local function toggle_expand()
	local name = plugin_at_cursor()
	if name then
		state.expanded[name] = not state.expanded[name]
		render()
		if state.expanded[name] then api.nvim_win_set_cursor(state.winid, { state.plugins_map[name], 8 }) end
	end
end

local function setup_keymaps()
	keymap("n", "q", "<Cmd>q<CR>", "Close")
	keymap("n", "<Esc>", "<Cmd>q<CR>", "Close")
	keymap("n", "g?", function()
		state.show_help = not state.show_help
		render()
	end, "Show help")
	keymap("n", "]]", function() jump_to_plugin(1) end, "Next plugin")
	keymap("n", "[[", function() jump_to_plugin(-1) end, "Previous plugin")
	keymap("n", "<CR>", function() toggle_expand() end, "Toggle plugin detail")
	keymap("n", "U", function()
		vim.cmd.quit()
		vim.pack.update()
	end, "Update all")
	keymap("n", "u", function()
		local name = plugin_at_cursor()
		if name then
			vim.cmd.quit()
			vim.pack.update({ name })
		end
	end, "Update plugin under cursor")
	keymap("n", "x", function()
		local name = plugin_at_cursor()
		if not name then return end

		local exist, plug_data = pcall(vim.pack.get, { name }, { info = false })
		if not exist then
			notify(string.format("%s is not installed", name), vim.log.levels.WARN)
			return
		end

		if #plug_data > 0 and plug_data[1].active then
			notify(string.format("%s is active, unload it before deletion", name), vim.log.levels.WARN)
			return
		end

		local choice =
			vim.fn.confirm(string.format("Are you sure you want to delete %s?", name), "&Yes\n&No", 2, "Question")
		if choice == 1 then
			vim.cmd.quit()
			local deleted, err = pcall(vim.pack.del, { name })
			if deleted then
				notify(string.format("%s has been deleted", name), vim.log.levels.INFO)
			else
				notify(tostring(err), vim.log.levels.ERROR)
			end
		end
	end, "Delete plugin under cursor")
end

local function open()
	if state.winid and api.nvim_win_is_valid(state.winid) then
		api.nvim_set_current_win(state.winid)
		return
	end

	-- create buffer
	state.bufnr = api.nvim_create_buf(false, true)
	vim.bo[state.bufnr].buftype = "nofile"
	vim.bo[state.bufnr].bufhidden = "wipe"
	vim.bo[state.bufnr].swapfile = false
	vim.bo[state.bufnr].filetype = plugname
	vim.b[state.bufnr].snacks_indent = false

	-- calculation window size
	local cols = vim.o.columns
	local lines = vim.o.lines
	local width = math.min(cols - 4, math.max(math.floor(cols * 0.8), 60))
	local height = math.min(lines - 4, math.max(math.floor(lines * 0.8), 20))
	local col = math.floor((cols - width) / 2)

	-- create floating window
	state.winid = api.nvim_open_win(state.bufnr, true, {
		relative = "editor",
		width = width,
		height = height,
		row = 2,
		col = col,
		style = "minimal",
		border = "rounded",
		title = " vim.pack ",
		title_pos = "center",
	})
	vim.wo[state.winid].cursorline = true
	vim.wo[state.winid].wrap = false

	render()
	setup_keymaps()

	local captured_winid = state.winid
	api.nvim_create_autocmd("WinClosed", {
		buffer = state.bufnr,
		once = true,
		callback = function(ev)
			if tonumber(ev.match) ~= captured_winid then return end
			state.winid = nil
			state.bufnr = nil
			state.expanded = {}
			state.show_help = false
		end,
	})
end

api.nvim_create_user_command("Pack", function() open() end, { desc = "Open vim.pack manager UI" })
