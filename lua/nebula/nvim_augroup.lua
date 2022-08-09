local api = vim.api

local M = {}

local function creates(definitions)
    for group_name, definition in pairs(definitions) do
        local id = api.nvim_create_augroup(group_name, { clear = true })
        for _, def in ipairs(definition) do
            def.opts.group = id
            api.nvim_create_autocmd(def.event, def.opts)
        end
    end
end

M.creates = creates

return M
