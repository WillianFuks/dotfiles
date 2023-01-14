local M = {}

local uv = vim.loop

function M.reload(folder)
    for name, _ in pairs(package.loaded) do
        if name:match("^" .. folder) then
            package.loaded[name] = nil
        end
    end
end

function M.is_dir(path)
    local stat = uv.fs_stat(path)
    return stat and stat.type == 'directory' or false
end

function M.write_file(path, content, mode)
    uv.fs_open(path, mode, 438, function(open_err, fd)
        assert(not open_err, open_err)
        uv.fs_write(fd, content, -1, function(write_err)
            assert(not write_err, write_err)
            uv.fs_close(fd, function(close_err)
                assert(not close_err, close_err)
            end)
        end)
    end)
end

return M
