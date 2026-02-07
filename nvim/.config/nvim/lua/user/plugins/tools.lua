return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = false,
    },
    keys = {
      -- Hunk navigation
      { "]h", function() require("gitsigns").next_hunk() end, desc = "Git: next hunk" },
      { "[h", function() require("gitsigns").prev_hunk() end, desc = "Git: prev hunk" },

      -- Hunk actions
      { "<leader>hp", function() require("gitsigns").preview_hunk() end, desc = "Git: preview hunk" },
      { "<leader>hr", function() require("gitsigns").reset_hunk() end,   desc = "Git: reset hunk" },
      { "<leader>hs", function() require("gitsigns").stage_hunk() end,   desc = "Git: stage hunk" },

      -- Blame
      { "<leader>hb", function() require("gitsigns").blame_line({ full = true }) end, desc = "Git: blame line" },

      -- Base switching (review vs normal)
      { "<leader>gbo", function() require("gitsigns").change_base("origin/main") end, desc = "Git: base = origin/main" },
      { "<leader>gbm", function() require("gitsigns").change_base("origin/master") end, desc = "Git: base = origin/master" },
      { "<leader>gbl", function() require("gitsigns").reset_base() end,               desc = "Git: base = local (reset)" },

      -- Optional: diff view for current file
      { "<leader>gd", function() require("gitsigns").diffthis() end, desc = "Git: diff this file" },
    },
  },
  {
    'echasnovski/mini.diff',
    event = 'VeryLazy',
    enabled = false,
    keys = {
      {
        '<leader>go',
        function()
          require('mini.diff').toggle_overlay(0)
        end,
        desc = 'Toggle mini.diff overlay',
      },
    },
    opts = {
      view = {
        style = 'sign',
        signs = {
          add = '▎',
          change = '▎',
          delete = '',
        },
      },
      mappings = {
        -- not use git throught neovim
        apply = '',
        reset = '',
        textobject = '',

        -- Go to hunk range in corresponding direction
        goto_first = '[H',
        goto_prev = '[h',
        goto_next = ']h',
        goto_last = ']H',
      },
    },
    config = function(_, opts)
      require('mini.diff').setup(opts)
      vim.cmd('highlight MiniDiffSignAdd guifg=#56d364')
      vim.cmd('highlight MiniDiffSignChange guifg=#e3b341')
      vim.cmd('highlight MiniDiffSignDelete guifg=#f85149')

      vim.cmd('highlight MiniDiffOverAdd guifg=#56d364')
      vim.cmd('highlight MiniDiffOverChange guifg=#e3b341')
      vim.cmd('highlight MiniDiffOverDelete guifg=#f85149')
    end,
  },
  {
    {
      'akinsho/toggleterm.nvim',
      version = '*',
      opts = {
        size = 20,
        open_mapping = [[<c-\>]],
        on_create = nil, -- function to run when the terminal is first created
        on_open = nil, -- function to run when the terminal opens
        on_close = nil, -- function to run when the terminal closes
        on_stdout = nil, -- callback for processing output on stdout
        on_stderr = nil, -- callback for processing output on stderr
        on_exit = nil, -- function to run when terminal process exits
        hide_numbers = true, -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
        shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
        shading_factor = nil, -- the percentage by which to lighten terminal background, default: -30 (gets multiplied by -3 if background is light)
        start_in_insert = true,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
        persist_size = false,
        persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
        direction = 'horizontal',
        close_on_exit = true, -- close the terminal window when the process exits
        -- Change the default shell. Can be a string or a function returning a string
        shell = vim.o.shell,
        auto_scroll = true, -- automatically scroll to the bottom on terminal output
        -- This field is only relevant if direction is set to 'float'
        winbar = {
          enabled = false,
          name_formatter = function(term) --  term: Terminal
            return term.name
          end,
        },
      },
      config = function(_, opts)
        require('toggleterm').setup(opts)
        vim.api.nvim_create_autocmd('TermOpen', {
          desc = 'Add mappings to navigate in terminals.',
          group = vim.api.nvim_create_augroup('toggleterm maps', { clear = true }),
          callback = function()
            local opts = { buffer = 0 }
            vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', 'fd', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
            vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
            vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
            vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
            vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
          end,
        })
      end,
    },
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  },
}
