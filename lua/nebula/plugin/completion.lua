local luasnip = require("luasnip")
local lspkind = require("lspkind")
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

local source_mapping = {
    nvim_lsp = "[LSP]",
    luasnip = "[LuaSnip]",
    buffer = "[Buffer]",
    path = "[Path]",
    spell = "[Spell]",
    nvim_lua = "[Lua]",
}

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

luasnip.config.setup({
    delete_check_events = "TextChanged,InsertLeave",
    region_check_events = "CursorMoved",
})

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable,
        ["<CR>"] = cmp.mapping.confirm({ select = false }),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol", -- show only symbol annotations
            maxwidth = 50,

            before = function(entry, vim_item)
                local menu = source_mapping[entry.source.name]

                vim_item.menu = menu

                return vim_item
            end
        }),
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "buffer" },
        { name = "path" },
        { name = "spell" },
        { name = "nvim_lua" },
    }, {
        { name = "git" },
    }),
})

require("cmp_git").setup()
