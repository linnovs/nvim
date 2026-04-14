---@diagnostic disable-next-line: duplicate-set-field
function string.starts(str, start) return string.sub(str, 1, string.len(start)) == start end
