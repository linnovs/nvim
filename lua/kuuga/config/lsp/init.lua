if vim.env.VIMDEBUG == "lsp" then
	vim.lsp.set_log_level("debug")
else
	vim.lsp.set_log_level("off")
end

require("kuuga.config.lsp.setup")
require("kuuga.config.lsp.diagnostic")
require("kuuga.config.lsp.attach")
