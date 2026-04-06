if os.getenv("TMUX") then
	-- https://www.reddit.com/r/neovim/comments/1sacc91/comment/oe1jbhh/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
	-- wrap message with tmux passthrough prefix

	---@param content string
	---@return string
	local function wrap_tmux(content)
		return string.format("\27Ptmux;\27%s\27\\", content)
	end

	local orig_ui_send = vim.api.nvim_ui_send

	---@diagnostic disable-next-line: duplicate-set-field
	vim.api.nvim_ui_send = function(content)
		content = wrap_tmux(content)
		orig_ui_send(content)
	end
end
