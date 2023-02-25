local nvim_tree_config = require('nvim-tree.config')

local tree_cb = nvim_tree_config.nvim_tree_callback

local function start_telescope(telescope_mode)
    local node = require('nvim-tree.lib').get_node_at_cursor()
    local abspath = node.link_to or node.absolute_path
    local is_folder = node.open ~= nil
    local basedir = is_folder and abspath or vim.fn.fnamemodify(abspath, ':h')
    require('telescope.builtin')[telescope_mode]({
        cwd = basedir,
    })
end

local function telescope_find_files(_)
    start_telescope('find_files')
end

local function telescope_live_grep(_)
    start_telescope('live_grep')
end

local function open_and_refocus(node)
    local nt_api = require('nvim-tree.api')
    nt_api.node.open.edit(node)
    nt_api.tree.focus()
end

local config = {
    setup = {
        ignore_ft_on_setup = {
            'startify',
            'dashboard',
            'alpha',
        },
        disable_netrw = true,
        hijack_directories = {
            enable = false,
        },
        sync_root_with_cwd = false,
        diagnostics = {
            enable = true,
        },
        update_focused_file = {
            enable = true,
            update_cwd = true,
        },
        system_open = {
            cmd = nil,
        },
        git = {
            ignore = false,
        },
        view = {
            adaptive_size = true,
            mappings = {
                list = {
                    { key = { '<CR>', 'o' }, action = 'edit' },
                    { key = { 'l' }, action = 'open_and_refocus', action_cb = open_and_refocus },
                    { key = 'v', action = 'vsplit' },
                    { key = 'h', cb = tree_cb('close_node') },
                    { key = 'C', action = 'cd' },
                    { key = 'gtf', action = 'telescope_find_files', action_cb = telescope_find_files },
                    { key = 'gtg', action = 'telescope_live_grep', action_cb = telescope_live_grep },
                },
            },
        },
        renderer = {
            highlight_git = true,
            icons = {
                glyphs = {
                    git = {
                        unstaged = '',
                    },
                },
            },
        },
        filters = {
            custom = { 'node_modules', '\\.cache', '\\.pyc$', '__pycache__' },
        },
        trash = {
            cmd = 'trash',
        },
        actions = {
            use_system_clipboard = true,
            open_file = {
                quit_on_open = false,
                resize_window = false,
            },
        },
    },
}

local nvimtree = require('nvim-tree')

nvimtree.setup(config.setup)

nnoremap('<leader>e', '<cmd>NvimTreeToggle<CR>', 'Toogles nvim tree')
