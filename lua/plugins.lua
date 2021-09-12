-- vim: foldmethod=marker

return require('packer').startup(function()
    -- Packer manage itself
    use { 'wbthomason/packer.nvim' }

    -- Utility {{{

    -- better mapping handling
    use { 'svermeulen/vimpeccable' }

    -- }}}

    -- Visual {{{

    -- colorscheme
    use { 'RRethy/nvim-base16' }

    -- }}}

end)
