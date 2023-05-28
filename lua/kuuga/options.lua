vim.opt.background = "dark" -- "dark" or "light", used for highlight colors
vim.opt.clipboard:append("unnamedplus") -- use the clipboard as the unnamed register
vim.opt.cmdheight = 1 -- number of lines to use for the command-line
vim.opt.colorcolumn = "+0" -- columns to highlight
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- options for Insert mode completion
vim.opt.conceallevel = 0 -- whether concealable text is shown or hidden
vim.opt.cursorline = true -- highlight the screen line of the cursor
vim.opt.expandtab = true -- use spaces when <Tab> is inserted
vim.opt.fileencoding = "utf-8" -- file encoding for multibyte text
vim.opt.fillchars = { eob = " ", fold = " ", foldopen = "", foldsep = " ", foldclose = "" } -- characters to use for displaying special items
vim.opt.foldcolumn = "1" -- columns to use for the fold column
vim.opt.foldenable = true -- set to display all folds open
vim.opt.foldlevel = 99 -- close folds with a level higher than this
vim.opt.foldlevelstart = 99 -- 'foldlevel' when starting to edit a file
vim.opt.guifont = "mononoki Nerd Font:h10.5"
vim.opt.iskeyword:append("-") -- characters included in keywords
vim.opt.list = true -- show <Tab> and <EOL>
vim.opt.listchars:append({ lead = "·" }) -- characters for displaying in list mode
vim.opt.listchars:append({ precedes = "<" })
vim.opt.listchars:append({ tab = "⭲ " })
vim.opt.listchars:append({ trail = "·" })
vim.opt.matchpairs:append({ "<:>" }) -- pairs of characters that "%" can match
-- vim.opt.mouse = "" -- disable the use of mouse clicks
vim.opt.number = true -- print the line number in front of each line
vim.opt.pastetoggle = "<F11>" -- key code that causes 'paste' to toggle
vim.opt.relativenumber = true -- show relative line number in front of each line
vim.opt.scrolloff = 4 -- minimum nr. of lines above and below cursor
vim.opt.shiftwidth = 0 -- number of spaces to use for (auto)indent step
vim.opt.shortmess:append("c") -- list of flags, reduce length of messages
vim.opt.showmode = false -- message on status line to show current mode
vim.opt.showtabline = 2 -- tells when the tab pages line is displayed
vim.opt.signcolumn = "yes:1" -- when and how to display the sign column
vim.opt.smartindent = true -- smart autoindenting for C programs
vim.opt.spell = true -- enable spell checking
vim.opt.spelloptions = "camel" -- options for spell checking
vim.opt.splitbelow = true -- new window from split is below the current one
vim.opt.splitright = true -- new window is put right of the current one
vim.opt.tabstop = 4 -- number of spaces that <Tab> in file uses
vim.opt.termguicolors = true -- truecolor support
vim.opt.textwidth = 120 -- maximum width of text that is being inserted
vim.opt.timeoutlen = 500 -- time out time in milliseconds
vim.opt.title = true -- let Vim set the title of the window
vim.opt.updatetime = 100 -- after this many milliseconds flush swap file
vim.opt.wrap = false -- long lines wrap and continue on the next line
