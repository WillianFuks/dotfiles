return {
  {
    'echasnovski/mini.cursorword',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('mini.cursorword').setup()
      vim.cmd('hi MiniCursorwordCurrent gui=underline')
      vim.cmd('hi MiniCursorword gui=underline')
    end,
  },
  {
    'echasnovski/mini.files',
    enabled = true,
    opts = {
      windows = {
        preview = false,
        width_focus = 50,
        width_preview = 50,
      },
      options = {
        permanent_delete = false,
      },
      mappings = {
        go_in_plus = '<CR>',
      },
    },
    keys = {
      {
        '<leader>e',
        function()
          local minifiles_toggle = function(...)
            if not MiniFiles.close() then
              MiniFiles.open(...)
            end
          end
          minifiles_toggle(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = 'Open mini.files (Directory of Current File)',
      },
      {
        '<leader>E',
        function()
          require('mini.files').open(vim.uv.cwd(), true)
        end,
        desc = 'Open mini.files (cwd)',
      },
    },
    config = function(_, opts)
      require('mini.files').setup(opts)

      local show_dotfiles = true
      local filter_show = function(fs_entry)
        return true
      end
      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, '.')
      end

      -----------------------------
      -- toogle dot files
      -----------------------------
      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        require('mini.files').refresh({ content = { filter = new_filter } })
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          -- Tweak left-hand side of mapping to your liking
          vim.keymap.set('n', 'I', toggle_dotfiles, { buffer = buf_id, desc = 'Toggle Hidden Files' })
        end,
      })
      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesActionRename',
        callback = function(event)
          require('user.utils').on_rename(event.data.from, event.data.to)
        end,
      })

      -----------------------------
      -- vertical/horizontal splitting
      -----------------------------
      local map_split = function(buf_id, lhs, direction)
        local rhs = function()
          local new_target_window
          vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
            vim.cmd(direction .. ' split')
            new_target_window = vim.api.nvim_get_current_win()
          end)
          MiniFiles.set_target_window(new_target_window)
        end
        local desc = 'Split ' .. direction
        vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          map_split(buf_id, '-', 'belowright horizontal')
          map_split(buf_id, '|', 'belowright vertical')
        end,
      })

      -- Close on <Esc>
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'minifiles',
        callback = function(args)
          vim.keymap.set(
            'n',
            '<Esc>',
            ':lua require"mini.files".close()<CR>',
            { buffer = args.buf_id, noremap = true, silent = true }
          )
        end,
      })

      -----------------------------
      -- change color
      -----------------------------
      vim.cmd('hi! link MiniFilesCursorLine Visual')

      -- mappings
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable('make') == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
    },
    config = function()
      require('telescope').setup({
        defaults = {
          mappings = {
            n = {
              ['q'] = require('telescope.actions').close,
              ['<c-d>'] = require('telescope.actions').delete_buffer
            },
          },
        },
        pickers = {},
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      })

      -- load dependencies
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'aerial')

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch [B]uffers' })
      vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = '[S]earch [M]arks' })
      vim.keymap.set('n', '<leader>ss', builtin.lsp_document_symbols, { desc = 'Goto Symbol' })
      vim.keymap.set('n', '<leader>sa', '<cmd>Telescope aerial<cr>', { desc = '[Search] [A]erial' })
      vim.keymap.set('n', '<leader>sH', '<cmd>Telescope highlights<cr>', { desc = 'Find highlight groups' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        })
      end, { desc = '[S]earch [/] in Open Files' })
    end,
  },
  {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    keys = {
      {
        '<leader>j',
        function()
          vim.cmd('HopWord')
        end,
        desc = 'Prepares for jumping anywhere in buffer to beginning of word',
      },
    },
    config = function()
      require('hop').setup({
        keys = 'asdghklwertyuiopzxcvbnmfj',
        create_hl_autocmd = true,
        quit_key = 'q',
      })
      vim.cmd([[hi HopNextKey1 guifg=#ff9900 gui=bold]])
      vim.cmd([[hi HopNextKey2 guifg=#00dfff gui=bold cterm=bold]])
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    enabled = false,
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    keys = function()
      local keys = {
        {
          "<leader>H",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Harpoon File",
        },
        {
          "<leader>h",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Quick Menu",
        },
      }
      for i = 1, 5 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Harpoon to File " .. i,
        })
      end
      return keys
    end,
  }
}
