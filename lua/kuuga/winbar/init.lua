require("kuuga.winbar.highlights")
require("kuuga.winbar.winbar")

local disabled_filetypes = { "help", "qf", "snacks_dashboard" }

local function set_winbar()
	local winid = vim.api.nvim_get_current_win()
	local bufnr = vim.api.nvim_win_get_buf(winid)
	if vim.list_contains(disabled_filetypes, vim.bo[bufnr].filetype) then return end
	if vim.bo[bufnr].filetype == "" then return end

	if vim.wo[winid].winbar == "" and vim.api.nvim_win_get_config(winid).relative == "" then
		WinBar.refresh()
		vim.wo[winid].winbar = "%{%v:lua.WinBar.render()%}"
	end
end

vim.api.nvim_create_autocmd({ "VimEnter", "WinNew", "WinEnter", "WinLeave", "BufEnter", "BufLeave" }, {
	group = vim.api.nvim_create_augroup("KuugaWinBar", { clear = true }),
	callback = function()
		for _, winid in ipairs(vim.api.nvim_list_wins()) do
			vim.api.nvim_win_call(winid, set_winbar)
		end
	end,
})
