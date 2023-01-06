vim.g.nvim_tree_refresh_wait = 500 --1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.

local vimp = require("vimp")

vimp.nnoremap("<Leader>op", ":NvimTreeToggle<CR>")

require("nvim-tree").setup({
    -- disables netrw completely
    disable_netrw = true,
    -- hijack netrw window on startup
    hijack_netrw = true,
    -- open the tree when running this setup function
    open_on_setup = false,
    -- will not open on setup if the filetype is in this list
    ignore_ft_on_setup = {},
    -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
    open_on_tab = true,
    -- hijack the cursor in the tree to put it at the start of the filename
    hijack_cursor = true,
    -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
    update_cwd = true,
    -- show lsp diagnostics in the signcolumn
    diagnostics = {
        enable = true,
        icons = {
            error = " ",
            warning = " ",
            hint = " ",
            info = " ",
        },
    },
    -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
    update_focused_file = {
        -- enables the feature
        enable = true,
        -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
        -- only relevant when `update_focused_file.enable` is true
        update_cwd = false,
        -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
        -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
        ignore_list = {},
    },
    -- configuration options for the system open command (`s` in the tree by default)
    system_open = {
        -- the command to run this, leaving nil should work in most cases
        cmd = nil,
        -- the command arguments as a list
        args = {},
    },
    -- false by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
    respect_buf_cwd = false,
    view = {
        -- width of the window, can be either a number (columns) or a string in `%`
        width = 30,
        -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
        side = "left",
        mappings = {
            -- custom only false will merge the list with the default mappings
            -- if true, it will only use your list to set the mappings
            custom_only = false,
            -- list of mappings to set on the tree manually
            list = {},
        },
    },
    filters = {
        dotfiles = false,
        custom = { "^.git$", "^node_modules$", "^.cache$" },
    },
    actions = {
        open_file = {
            -- disabled by default, closes the tree when you open a file
            quit_on_open = true,
            -- if true the tree will resize itself after opening a file
            resize_window = false,
            -- disabled by default, will disable the window picker.
            window_picker = {
                enable = true,
                -- Dictionary of buffer option names mapped to a list of option values that
                -- indicates to the window picker that the buffer's window should not be
                -- selectable.
                exclude = {
                    filetype = {
                        "packer",
                        "qf",
                    },
                    buftype = {
                        "terminal",
                    },
                },
            },
        },
    },
    renderer = {
        --0 by default, append a trailing slash to folder names
        add_trailing = true,
        -- false by default, compact folders that only contain a single folder into one node in the file tree
        group_empty = true,
        --false by default, will enable file highlight for git attributes (can be used without the icons).
        highlight_git = true,
        --0 by default, will enable folder and file icon highlight for opened files/directories.
        highlight_opened_files = "3",
        -- off by default, this option shows indent markers when folders are open
        indent_markers = {
            enable = true,
            icons = {
                corner = "└ ",
                edge = "│ ",
                none = "  ",
            },
        },
        icons = {
            --one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
            padding = " ",
            -- defaults to ' ➛ '. used as a separator between symlinks' source and target.
            symlink_arrow = " >> ",
            show = {
                git = true,
                folder = true,
                file = true,
                folder_arrow = true,
            },
            glyphs = {
                -- default will show icon by default if no icon is provided
                -- default shows no icon by default
                default = "",
                symlink = "",
                git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "★",
                    deleted = "",
                    ignored = "◌",
                },
                folder = {
                    arrow_open = "",
                    arrow_closed = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
            },
        },
        -- List of filenames that gets highlighted with NvimTreeSpecialFile
        special_files = { "README.md", "Makefile", "MAKEFILE" },
        --This is the default. See :help filename-modifiers for more options
        root_folder_modifier = ":~",
    },
})
