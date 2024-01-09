local api = vim.api
local ts = vim.treesitter

-- function modified from vim.treesitter.foldtext
local function foldendtext()
	local foldend = vim.v.foldend
	local bufnr = api.nvim_get_current_buf()

	---@type boolean, LanguageTree
	local ok, parser = pcall(ts.get_parser, bufnr)
	if not ok then
		return nil
	end

	local query = ts.query.get(parser:lang(), "highlights")
	if not query then
		return nil
	end

	local tree = parser:parse({ foldend - 1, foldend })[1]

	local line = api.nvim_buf_get_lines(bufnr, foldend - 1, foldend, false)[1]
	if not line then
		return nil
	end

	---@type { [1]: string, [2]: string[], range: { [1]: integer, [2]: integer } }[] | { [1]: string, [2]: string[] }[]
	local result = {}

	local line_pos = 0

	for id, node, metadata in query:iter_captures(tree:root(), 0, foldend - 1, foldend) do
		local name = query.captures[id]
		local start_row, start_col, end_row, end_col = node:range()

		local priority = tonumber(metadata.priority or vim.highlight.priorities.treesitter)

		if start_row == foldend - 1 and end_row == foldend - 1 then
			-- check for characters ignored by treesitter
			if start_col > line_pos then
				table.insert(result, {
					line:sub(line_pos + 1, start_col),
					{ { "Folded", priority } },
					range = { line_pos, start_col },
				})
			end
			line_pos = end_col

			local text = line:sub(start_col + 1, end_col)
			table.insert(result, { text, { { "@" .. name, priority } }, range = { start_col, end_col } })
		end
	end

	local i = 1
	while i <= #result do
		-- find first capture that is not in current range and apply highlights on the way
		local j = i + 1
		while j <= #result and result[j].range[1] >= result[i].range[1] and result[j].range[2] <= result[i].range[2] do
			for k, v in ipairs(result[i][2]) do
				if not vim.tbl_contains(result[j][2], v) then
					table.insert(result[j][2], k, v)
				end
			end
			j = j + 1
		end

		-- remove the parent capture if it is split into children
		if j > i + 1 then
			table.remove(result, i)
		else
			-- highlights need to be sorted by priority, on equal prio, the deeper nested capture (earlier
			-- in list) should be considered higher prio
			if #result[i][2] > 1 then
				table.sort(result[i][2], function(a, b)
					return a[2] < b[2]
				end)
			end

			result[i][2] = vim.tbl_map(function(tbl)
				return tbl[1]
			end, result[i][2])
			result[i] = { result[i][1], result[i][2] }

			i = i + 1
		end
	end

	local first = result[1]
	result[1] = { vim.trim(first[1]), first[2] }

	return result
end

local function foldlines(foldstart, foldend)
	local line = string.format("   %s lines ", foldend - foldstart + 1)

	return {
		line,
		"Folded",
	}
end

_G.KuugaFoldText = function()
	local foldstart = vim.v.foldstart
	local foldend = vim.v.foldend
	local foldtext = ts.foldtext()
	local foldend_text = foldendtext()
	local folded_lines = foldlines(foldstart, foldend)

	if type(foldtext) == "string" then
		return {
			{ foldtext, "Normal" },
		}
	end

	table.insert(foldtext, folded_lines)

	if foldend_text then
		for _, item in ipairs(foldend_text) do
			table.insert(foldtext, item)
		end
	end

	return foldtext
end
