local fzf = require("fzf-lua")

local M = {}

local function create_fzf_exec(prompt, query)
	local base_url = "https://cht.sh/"
	local curl_cmd = "curl -s "

	fzf.fzf_exec(curl_cmd .. base_url .. query, {
		prompt = prompt .. " > ",
		fzf_opts = {
			["--preview"] = {
				type = "cmd",
				fn = function(items)
					return curl_cmd .. base_url .. items[1]
				end,
			},
		},
	})
end

function M.cht_sh_list()
	create_fzf_exec("Cheatsheet for " .. vim.bo.filetype, vim.bo.filetype)
end

function M.query_cht_sh()
	create_fzf_exec("Search in Cheatsheet", ":list")
end

return M
