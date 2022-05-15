local cache = vim.fn.stdpath("cache")
local flock_path = cache .. "/packer.autoupdate.lock"

local function should_update()
    local file = io.open(cache .. "/packer.autoupdate", "r+")

    if not file then
        file = io.open(cache .. "/packer.autoupdate", "w+")
    end

    local now = os.time()
    local last_update

    local content = file:read("*l")
    if not content then
        last_update = now
    else
        last_update = now - os.time(os.date("*t", tonumber(content)))
    end

    if last_update > 5 * 86400 and os.date("%w", now) >= 5 then
        file:seek("set")
        file:write(now)
        file:flush()
        file:close()

        return true
    end

    return false
end

-- don't run if the file lock exist
if 0 < os.execute("mkdir " .. flock_path .. " >/dev/null 2>&1") then
    return
end

if should_update() then
    vim.cmd("PackerSync")
end

os.execute("rmdir " .. flock_path)
