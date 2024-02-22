return function(mode, lhs, rhs, desc, opts)
	if opts == nil then
		opts = {
			desc = desc,
		}
	else
		opts["desc"] = desc
	end

	vim.keymap.set(mode, lhs, rhs, opts)
end
