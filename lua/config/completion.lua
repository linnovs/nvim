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
    cmp_tabnine = "[tabnine]",
}

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

luasnip.config.setup({
    delete_check_events = "TextChanged,InsertLeave",
    region_check_events = "CursorMoved",
})

lspkind.init({
    -- defines how annotations are shown
    -- default: symbol
    -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
    mode = "symbol_text",

    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = "default",

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "ﰠ",
        Variable = "",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Property = "ﰠ",
        Unit = "塞",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "פּ",
        Event = "",
        Operator = "",
        TypeParameter = "",
    },
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
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

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
                if entry.source.name == "cmp_tabnine" then
                    if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                        menu = entry.completion_item.data.detail .. " " .. menu
                    end
                    vim_item.kind = "Event"
                end

                vim_item.menu = menu

                return vim_item
            end,
        }),
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "cmp_tabnine" },
    }, {}, {
        { name = "buffer" },
        { name = "path" },
        { name = "spell" },
        { name = "nvim_lua" },
    }, {
        { name = "git" },
    }),
})

cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = "buffer" } }),
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

require("cmp_git").setup()
