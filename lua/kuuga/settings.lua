-- map the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set up options
vim.opt.colorcolumn = "+1" -- columns to highlight
vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer
vim.opt.diffopt:append({ algorithm = "histogram", linematch = 60 }) -- options for using diff mode
vim.opt.exrc = true -- allow project-local .nvimrc files
vim.opt.inccommand = "split" -- preview substitutions live
vim.opt.laststatus = 3 -- tells when last window has status lines
vim.opt.mouse = "a" -- enable mouse support for all modes (unless |hit-enter| and |more-prompt|)
vim.opt.scrolloff = 7 -- Minimum number of screen lines to keep above and below the cursor
vim.opt.showmode = false -- hide the mode since it's shown in the statusline
vim.opt.signcolumn = "yes" -- keep signcolumn on by default
vim.opt.textwidth = 120 -- set maximum width of text that is being inserted
vim.opt.undofile = true -- save undo history to an undo file

-- cursor lines settings
vim.opt.cursorline = true
vim.opt.cursorlineopt = "screenline,number"

-- line number
vim.opt.number = true
vim.opt.relativenumber = true

-- indent settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 0
vim.opt.tabstop = 4

-- line wrapping settings
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.linebreak = true

-- Decrease timeout and update time to make vim more responsive
vim.opt.timeoutlen = 300 -- Decrease mapped sequence timeout (default is 1000ms)
vim.opt.updatetime = 250 -- Decrease update time (default is 4000ms)

-- case-insensitive search unless \C / one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Split windows to the right and below
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"

-- set how neovim displays whitespace characters
vim.opt.list = true
vim.opt.listchars = { extends = "", lead = "·", tab = "󰌒 ", trail = "·", nbsp = "␣" }

-- fold settings
vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- Disable providers we don't use to speed up startup time
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
