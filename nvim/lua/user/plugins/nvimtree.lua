local nvim_tree_config = require 'nvim-tree.config'

local tree_cb = nvim_tree_config.nvim_tree_callback

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
      mappings = {
        list = {
          { key = { 'l', '<CR>', 'o' }, action = 'edit' },
          { key = 'v', action = 'vsplit' },
          { key = 'h', cb = tree_cb 'close_node' },
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
                  unstaged = "",

              }
          }
      }
    },
    filters = {
      custom = { 'node_modules', '\\.cache', '\\.pyc$' },
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

local nvimtree = require 'nvim-tree'
local utils = require 'nvim-tree.utils'

local function notify_level()
  return function(msg)
    vim.schedule(function()
      vim.api.nvim_echo({ { msg, 'WarningMsg' } }, false, {})
    end)
  end
end

utils.notify.warn = notify_level(vim.log.levels.WARN)
utils.notify.error = notify_level(vim.log.levels.ERROR)
utils.notify.info = notify_level(vim.log.levels.INFO)
utils.notify.debug = notify_level(vim.log.levels.DEBUG)

-- if config._setup_called then
--   --Log:debug 'ignoring repeated setup call for nvim-tree, see kyazdani42/nvim-tree.lua#1308'
--   return
-- end

nnoremap('<leader>e', '<cmd>NvimTreeToggle<CR>', 'Toogles nvim tree')

-- config._setup_called = true

-- Implicitly update nvim-tree when project module is active
--if lvim.builtin.project.active then
--  lvim.builtin.nvimtree.setup.respect_buf_cwd = true
--  lvim.builtin.nvimtree.setup.update_cwd = true
--  lvim.builtin.nvimtree.setup.update_focused_file = { enable = true, update_cwd = true }
--end

local function start_telescope(telescope_mode)
  local node = require('nvim-tree.lib').get_node_at_cursor()
  local abspath = node.link_to or node.absolute_path
  local is_folder = node.open ~= nil
  local basedir = is_folder and abspath or vim.fn.fnamemodify(abspath, ':h')
  require('telescope.builtin')[telescope_mode] {
    cwd = basedir,
  }
end

local function telescope_find_files(_)
  start_telescope 'find_files'
end

local function telescope_live_grep(_)
  start_telescope 'live_grep'
end

nvimtree.setup(config.setup)
