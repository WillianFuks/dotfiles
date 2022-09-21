local M = {}

local _uv = vim.loop

function M.reload(folder)
    for name, _ in pairs(package.loaded) do
        if name:match("^" .. folder) then
        package.loaded[name] = nil
    end
    end
end 

function M.is_dir(path)
    local r = _uv.fs_stat(path)
    return stat and stat.type == 'directory' or false
end

return M
