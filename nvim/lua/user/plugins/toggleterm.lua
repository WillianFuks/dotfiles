local config = {
  size = 15,
  open_mapping = [[<c-\>]],
  on_open = nil,
  on_close = nil,
  highlights = {
    Normal = {
        guibg = '#090B10',
    }
  },
  on_stdout = nil,
  on_stderr = nil,
  on_exit = nil,
  hide_numbers = true,
  shade_filetypes = {},
  autochdir = false,
  shade_terminals = false,
  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true,
  persist_size = false,
  persist_mode = false,
  direction = 'horizontal',
  close_on_exit = true,
  shell = vim.o.shell,
  auto_scroll = true,
  winbar = {
    enabled = false,
  },
}

require('toggleterm').setup(config)

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
vim.api.nvim_create_autocmd( { 'TermOpen' }, {
    group = vim.api.nvim_create_augroup('ToggleTermOpen', {}),
    pattern = { 'term://*' },
    callback = function()
        set_terminal_keymaps()
    end,
    desc = 'Adds ToggleTerm keymappings to make it possible to move around the terminal'
})
