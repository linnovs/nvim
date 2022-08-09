-- vim: foldmethod=marker foldlevel=0

return require("packer").startup({
    function(use)
        -- Packer manage itself
        use({ "wbthomason/packer.nvim" })

        -- Utility {{{

        -- startup time
        use({ "tweekmonster/startuptime.vim", cmd = "StartupTime" })

        -- better mapping handling
        use({ "svermeulen/vimpeccable" })

        -- commenting
        use({ "b3nj5m1n/kommentary" })

        use({ "tpope/vim-surround" })

        use({
            "windwp/nvim-autopairs",
            config = function()
                require("nebula.plugin.autopairs")
            end,
        })

        use("gpanders/editorconfig.nvim")

        use({
            "numtostr/FTerm.nvim",
            config = function()
                require("nebula.plugin.terminal")
            end,
        })

        -- coding time logging
        use({ "wakatime/vim-wakatime" })

        -- }}}

        -- Visual {{{

        -- indent-guideline
        use({
            "lukas-reineke/indent-blankline.nvim",
            config = function()
                require("nebula.plugin.indent-guideline")
            end,
        })

        --[[ -- smooth scrolling
        use({
            "karb94/neoscroll.nvim",
            config = function()
                require("nebula.plugin.smoothscroll")
            end,
        }) ]]

        -- todo-comment
        use({
            "folke/todo-comments.nvim",
            requires = "nvim-lua/plenary.nvim",
            config = function()
                require("nebula.plugin.todo-comments")
            end,
        })

        -- color highlighter
        use({
            "norcalli/nvim-colorizer.lua",
            config = function()
                require("colorizer").setup()
            end,
        })

        -- notification
        use({
            "rcarriga/nvim-notify",
            config = function()
                require("nebula.plugin.notify")
            end,
        })

        -- }}}

        -- UI {{{

        -- tokyo night colorscheme
        use("folke/tokyonight.nvim")

        -- dashboard
        use({
            "goolord/alpha-nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("nebula.plugin.dashboard")
            end,
        })

        -- git
        use({
            "lewis6991/gitsigns.nvim",
            requires = { "nvim-lua/plenary.nvim" },
            config = function()
                require("nebula.plugin.gitsign")
            end,
        })

        -- tabline
        use({
            "akinsho/bufferline.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("nebula.plugin.bufferline")
            end,
        })

        -- statusline
        --[[ use({
			"famiu/feline.nvim",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = function()
				require("nebula.plugin.statusline.feline")
			end,
		}) ]]
        use({
            "nvim-lualine/lualine.nvim",
            requires = { "kyazdani42/nvim-web-devicons" },
            config = function()
                require("nebula.plugin.statusline.lualine")
            end,
        })

        -- file explorer
        use({
            "kyazdani42/nvim-tree.lua",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("nebula.plugin.explorer")
            end,
            tag = "nightly"
        })

        -- beauty fold
        use({
            'kevinhwang91/nvim-ufo',
            requires = 'kevinhwang91/promise-async',
            config = function()
                require("nebula.plugin.ufo")
            end
        })

        -- beauty default UI
        use({
            'stevearc/dressing.nvim',
            config = function()
                require("nebula.plugin.dressing")
            end
        })

        -- which-key
        use({
            "folke/which-key.nvim",
            config = function()
                require("nebula.plugin.which-key")
            end,
        })

        -- }}}

        -- Syntax {{{

        -- treesitter
        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function()
                require("nebula.plugin.treesitter")
            end,
        })

        use({
            "lewis6991/spellsitter.nvim",
            config = function()
                require("nebula.plugin.spellsitter")
            end,
        })

        use({ "nvim-treesitter/playground", requires = { "nvim-treesitter/nvim-treesitter" } })

        use({ "alker0/chezmoi.vim" })

        -- }}}

        -- LSP {{{

        -- native LSP configuration
        use({
            "neovim/nvim-lspconfig",
            config = function()
                require("nebula.lsp")
            end,
            requires = {
                "williamboman/nvim-lsp-installer",
                "ray-x/lsp_signature.nvim",
            },
        })

        -- code context
        use({
            "SmiteshP/nvim-navic",
            config = function()
                require("nebula.plugin.navic")
            end,
            requires = {
                "neovim/nvim-lspconfig"
            }
        })

        -- codeAction
        use({ "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" })

        -- trouble
        use({
            "folke/trouble.nvim",
            config = function()
                require("nebula.plugin.trouble")
            end,
        })

        -- completion
        use({
            "hrsh7th/nvim-cmp",
            config = function()
                require("nebula.plugin.completion")
                require("nebula.plugin.lspkind")
            end,
        })

        -- completion source {{{
        use({ "hrsh7th/cmp-nvim-lsp", requires = { "hrsh7th/nvim-cmp" } }) -- lsp source
        use({ "hrsh7th/cmp-buffer", requires = { "hrsh7th/nvim-cmp" } }) -- buffer source
        use({ "L3MON4D3/LuaSnip", requires = { "hrsh7th/nvim-cmp" } }) -- snippet engine
        use({ "saadparwaiz1/cmp_luasnip", requires = { "hrsh7th/nvim-cmp" } }) -- snippet source
        use({ "hrsh7th/cmp-path", requires = { "hrsh7th/nvim-cmp" } }) -- path source
        use({ "f3fora/cmp-spell", requires = { "hrsh7th/nvim-cmp" } }) -- spell source
        use({ "hrsh7th/cmp-nvim-lua", requires = { "hrsh7th/nvim-cmp" } }) -- nvim-lua source
        use({ "onsails/lspkind-nvim", requires = { "hrsh7th/nvim-cmp" } }) -- vscode-like pictograms
        use({ "petertriho/cmp-git", requires = { "hrsh7th/nvim-cmp" } }) -- git related source
        use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = { "hrsh7th/nvim-cmp" } }) -- tabnine source
        -- }}}

        -- lint
        use({
            "jose-elias-alvarez/null-ls.nvim",
            requires = {
                "nvim-lua/plenary.nvim",
                "neovim/nvim-lspconfig",
            },
        })

        -- virtual type
        use({
            "jubnzv/virtual-types.nvim",
            requires = {
                "neovim/nvim-lspconfig",
            },
        })

        -- }}}

        -- Tool {{{

        -- markdown preview
        use({ "davidgranstrom/nvim-markdown-preview", cmd = { "MarkdownPreview" } })

        -- telescope fuzzy finder
        use({
            "nvim-telescope/telescope.nvim",
            config = function()
                require("nebula.plugin.telescope")
            end,
            requires = {
                "nvim-lua/plenary.nvim",
                "kyazdani42/nvim-web-devicons",
                "jvgrootveld/telescope-zoxide",
            },
        })

        -- github integration
        use({
            "pwntester/octo.nvim",
            cmd = { "Octo" },
            config = function()
                require("nebula.plugin.github")
            end,
        })

        -- zen mode
        use({
            "folke/zen-mode.nvim",
            config = function()
                require("nebula.plugin.zen")
            end,
        })

        -- }}}
    end,
    config = {
        display = {
            open_fn = function()
                return require("packer.util").float({ border = "single" })
            end,
        },
    },
})
