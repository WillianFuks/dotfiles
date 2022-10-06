local default_opts = { noremap = true, silent = true }

local function partial(mode, opts)
    opts = opts or default_opts
    return function(lhs, rhs, desc)
        opts['desc'] = desc or ''
        vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
    end
end

nnoremap = partial('n')
vnoremap = partial('v')
inoremap = partial('i')
cnoremap = partial('i', { expr = true, noremap = true })

nnoremap('<leader><leader>x', ':source %<CR>', 'Sources current buffer')
nnoremap(
    '<leader><leader>X',
    [[<Cmd>lua _G._is_reload = true local ok, packer = pcall(require, 'packer') if ok then packer.reset() end vim.cmd 'luafile $MYVIMRC'<CR>]],
    'Sources config init.lua file which reloads the whole setup of neovim config'
)

nnoremap('<leader>s', ':w<CR>', 'Regular file save')

nnoremap('<leader><space>', ':noh<CR>', 'Removes text highlighting')

nnoremap('B', '^', 'Moves to the beginning of first non-empty character in row')
vnoremap('B', '^')
nnoremap('E', '$', 'Moves to the end of row')
vnoremap('E', '$')

nnoremap('zl', 'zL', 'Jump cursor to the right')
vnoremap('zl', 'zL', 'Jump cursor to the right')
nnoremap('zh', 'zH', 'Jump cuHsor to the left')
vnoremap('zh', 'zH', 'Jump cuHsor to the left')

nnoremap('<C-J>', '<C-W><C-J>', 'Jump to window below')
nnoremap('<C-K>', '<C-W><C-K>', 'Jump to window above')
nnoremap('<C-L>', '<C-W><C-L>', 'Jump to window to the right')
nnoremap('<C-H>', '<C-W><C-H>', 'Jump to window to the left')

nnoremap('<leader>q', ':bd<CR>', 'Closes current buffer')

nnoremap(
    'j',
    'gj',
    'Makes cursor walk down through wrapped lines (lines that goes beyond the available space in the buffer window size'
)
nnoremap('k', 'gk')

nnoremap('dE', 'd$', 'Deletes until end of line')

-- nnoremap(
--     '<F5>',
--     [[:let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s<CR>]],
--     'Removes white spaces'
-- )

inoremap('fd', '<esc>', 'Leaves insert mode to normal mode')

vnoremap('<leader>y', '"+y', 'Copy content to clipboard')
nnoremap('<leader>Y', '"+yg_')
nnoremap('<leader>y', '"+y')
nnoremap('<leader>yy', '"+yy')

nnoremap('<leader>p', '"+p', 'Paste content from cipboard')
nnoremap('<leader>P', '"+P')
vnoremap('<leader>p', '"+p')
vnoremap('<leader>P', '"+P')
vnoremap('p', '"_dP', 'Avoids yanking text when pasting on visual mode - pasting on selected text')

nnoremap('<C-Up>', ':resize -2<CR>', 'Resize window')
nnoremap('<C-Down>', ':resize +2<CR>')
nnoremap('<C-Left>', ':vertical resize -2<CR>')
nnoremap('<C-Right>', ':vertical resize +2<CR>')

vnoremap('<', '<gv', 'Push selected lines to the left indentation')
vnoremap('>', '>gv', 'Push selected lines to the right indentation')

cnoremap('<C-j>', 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', 'Navigate tab completion in command mode')
cnoremap('<C-k>', 'pumvisible() ? "\\<C-p>" : "\\<C-k>"')

nnoremap('<C-d>', '<C-d>zz')
nnoremap('<C-u>', '<C-u>zz')

nnoremap('g[', ':lua vim.diagnostic.goto_prev()<CR>', 'Go to previous LSP diagnostics')
nnoremap('g]', ':lua vim.diagnostic.goto_next()<CR>', 'Go to next LSP diagnostics')

nnoremap('<leader>fo', ':lua vim.lsp.buf.format()<CR>', 'Formats code if formatter is available')
nnoremap('<leader>a', ':lua vim.lsp.buf.code_action()<CR>', 'Code Actions')
vnoremap('<leader>a', ':lua vim.lsp.buf.code_action()<CR>', 'Code Actions')

nnoremap('<leader>l', ':lua vim.lsp.codelens.run()<CR>', 'Code Lens')
vnoremap('<leader>l', ':lua vim.lsp.codelens.run()<CR>', 'Code Lens')
