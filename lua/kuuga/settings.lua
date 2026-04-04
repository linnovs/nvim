-- map the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set up options
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.mouse = "a" -- enable mouse support for all modes (unless |hit-enter| and |more-prompt|)
vim.opt.showmode = false -- hide the mode since it's shown in the statusline
vim.opt.breakindent = true -- wrapped line repeats indent
vim.opt.undofile = true -- save undo history to an undo file
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.exrc = true -- allow project-local .nvimrc files
vim.opt.textwidth = 120 -- set maximum width of text that is being inserted
vim.opt.tabstop = 4 -- number of spaces tabs count for
vim.opt.colorcolumn = "+1" -- columns to highlight

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end) -- sync clipboard with system clipboard

-- case-insensitive search unless \C / one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes" -- keep signcolumn on by default
vim.opt.updatetime = 250 -- Decrease update time (default is 4000ms)
vim.opt.timeoutlen = 300 -- Decrease mapped sequence timeout (default is 1000ms)

-- Split windows to the right and below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- set how neovim displays whitespace characters
vim.opt.list = true
vim.opt.listchars = { extends = "", lead = "·", tab = "󰌒 ", trail = "·", nbsp = "␣" }

vim.opt.inccommand = "split" -- preview substitutions live
vim.opt.cursorline = true -- highlight the current line
vim.opt.scrolloff = 7 -- Minimum number of screen lines to keep above and below the cursor
vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer

-- Disable providers we don't use to speed up startup time
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
