return function(mode, lhs, rhs, desc, opts)
	opts = opts or {}
	if desc then
		opts.desc = desc
	end
	vim.keymap.set(mode, lhs, rhs, opts)
end
