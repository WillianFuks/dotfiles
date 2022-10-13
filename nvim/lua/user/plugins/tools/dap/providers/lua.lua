local dap = require('dap')

dap.adapters.nlua = function(callback, config)
    callback({ type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 })
end

nnoremap(
    '<leader>dll', --"Dap Lua Launch"
    [[:lua require"osv".launch({port = 8086})<CR>]],
    'This command initializes the lua server to run at the background and receive the request from nvim dap client'
)

nnoremap(
    '<leader>drl', --"Dap Run Lua"
    [[:lua require'osv'.run_this()<CR>]],
    'Runs lua debugger directly. First set a break point at the code.'
)

-- nnoremap(
--     '<leader>dsl', --"Dap Stop Lua, apparently only works inside repl"
--     [[:lua require'osv'.stop()<CR>]],
--     'Stops lua dap server'
-- )
