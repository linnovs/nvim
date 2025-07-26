vim.opt.background = "dark" -- "dark" or "light", used for highlight colors
vim.opt.backupcopy = "yes" -- make backup as a copy, don't rename the file
vim.opt.cmdheight = 1 -- number of lines to use for the command-line
vim.opt.colorcolumn = "+0" -- columns to highlight
vim.opt.completeopt = { "menu", "menuone", "preview", "noinsert", "noselect" } -- options for Insert mode completion
vim.opt.conceallevel = 0 -- whether concealable text is shown or hidden
vim.opt.cursorline = true -- highlight the screen line of the cursor
vim.opt.diffopt:append({ algorithm = "histogram", linematch = 50 })
vim.opt.expandtab = true -- use spaces when <Tab> is inserted
vim.opt.fileencoding = "utf-8" -- file encoding for multibyte text
vim.opt.fillchars = { eob = "·", fold = " ", foldopen = "", foldsep = " ", foldclose = "" } -- characters to use for displaying special items
vim.opt.foldcolumn = "1" -- columns to use for the fold column
vim.opt.foldenable = true -- set to display all folds open
vim.opt.foldlevel = 99 -- close folds with a level higher than this
vim.opt.foldlevelstart = 99 -- 'foldlevel' when starting to edit a file
vim.opt.foldtext = "" -- expression used to display for a closed fold
vim.opt.guifont = "JetBrains Mono,Symbols Nerd Font,Noto Color Emoji:h12"
vim.opt.iskeyword:append("-") -- characters included in keywords
vim.opt.list = true -- show <Tab> and <EOL>
vim.opt.listchars:append({
	extends = "󰞘",
	lead = "·",
	multispace = "··",
	nbsp = ".",
	precedes = "󰞗",
	tab = "⭲ ",
	trail = "·",
}) -- characters for displaying in list mode
vim.opt.matchpairs:append({ "<:>" }) -- pairs of characters that "%" can match
vim.opt.number = true -- print the line number in front of each line
vim.opt.relativenumber = true -- show relative line number in front of each line
vim.opt.scrolloff = 4 -- minimum nr. of lines above and below cursor
vim.opt.shiftwidth = 0 -- number of spaces to use for (auto)indent step
vim.opt.shortmess:append("c") -- list of flags, reduce length of messages
vim.opt.showmode = false -- message on status line to show current mode
vim.opt.showtabline = 2 -- tells when the tab pages line is displayed
vim.opt.signcolumn = "yes:1" -- when and how to display the sign column
vim.opt.smartindent = true -- smart autoindenting for C programs
vim.opt.spell = false -- disable spell checking
vim.opt.spelloptions = "camel" -- options for spell checking
vim.opt.splitbelow = true -- new window from split is below the current one
vim.opt.splitright = true -- new window is put right of the current one
vim.opt.tabstop = 4 -- number of spaces that <Tab> in file uses
vim.opt.laststatus = 3 -- tells when last window has status lines
vim.opt.termguicolors = true -- truecolor support
vim.opt.textwidth = 115 -- maximum width of text that is being inserted
vim.opt.timeout = true -- time out on mappings and key codes
vim.opt.timeoutlen = 300 -- time out time in milliseconds
vim.opt.title = true -- let Vim set the title of the window
vim.opt.updatetime = 100 -- after this many milliseconds flush swap file
vim.opt.wrap = false -- long lines wrap and continue on the next line
