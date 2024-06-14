return {
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  {
    'echasnovski/mini.statusline',
    version = '*',
    config = function()
      local opts = {
        content = {
          active = function()
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local git = MiniStatusline.section_git({ trunc_width = 75 })
            local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
            local filename = MiniStatusline.section_filename({ trunc_width = 75 })
            -- local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            local location = MiniStatusline.section_location({ trunc_width = 75 })
            local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

            return MiniStatusline.combine_groups({
              -- { hl = mode_hl, strings = { mode } },
              { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
              '%<', -- Mark general truncate point
              { hl = 'MiniStatuslineFileinfo', strings = { filename } },
              '%=', -- End left alignment
              -- { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              { hl = 'MiniStatuslineFileinfo', strings = { search, location } },
            })
          end,
          inactive = nil,
        },
        use_icons = true,
        set_vim_settings = false,
      }
      require('mini.statusline').setup(opts)

      vim.cmd('hi! link MiniStatuslineModeNormal PmenuSel')
    end,
  },
  {
    'echasnovski/mini.tabline',
    enabled = false,
    version = '*',
    opts = {
      show_icons = true,
      set_vim_settings = true,
      tabpage_section = 'left',
    },
    config = function(_, opts)
      require('mini.tabline').setup(opts)

      vim.cmd('hi! link MiniTablineCurrent NvimTreeWindowPicker')
      vim.cmd('hi! link MiniTablineModifiedCurrent CursorLineNr')
      vim.cmd('hi! link MiniTablineModifiedHidden WarningMsg')
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = true,
    main = 'ibl',
    opts = {
      enabled = true,
      debounce = 400,
      viewport_buffer = {
        min = 30,
        max = 500,
      },
      indent = {
        char = '┊',
        tab_char = nil,
        highlight = { 'IblIndent' },
        smart_indent_cap = true,
        priority = 2,
        repeat_linebreak = true,
      },
      whitespace = {
        highlight = 'IblWhitespace',
        remove_blankline_trail = true,
      },
      scope = {
        enabled = false,
        char = nil,
        show_start = true,
        show_end = true,
        show_exact_scope = false,
        injected_languages = true,
        highlight = 'IblScope',
        priority = 1024,
        include = {
          node_type = {},
        },
        exclude = {
          language = {},
          node_type = {
            ['*'] = {
              'source_file',
              'program',
            },
            lua = {
              'chunk',
            },
            python = {
              'module',
            },
          },
        },
      },
      exclude = {
        filetypes = {
          'lspinfo',
          'packer',
          'checkhealth',
          'help',
          'man',
          'gitcommit',
          'TelescopePrompt',
          'TelescopeResults',
          '',
        },
        buftypes = {
          'terminal',
          'nofile',
          'quickfix',
          'prompt',
        },
      },
    },
    config = function(_, opts)
      -- vim.cmd('hi IblIndent guifg=#31363d')
      require('ibl').setup(opts)
    end,
  },
  {
    'echasnovski/mini.indentscope',
    version = '*',
    enabled = false,
    config = function()
      local opts = {
        draw = {
          delay = nil,
          animation = require('mini.indentscope').gen_animation.none(), 
          priority = nil,
        },
        mappings = {
          -- Textobjects
          object_scope = 'ii',
          object_scope_with_border = 'ai',
          -- Motions (jump to respective border line; if not present - body line)
          goto_top = '[i',
          goto_bottom = ']i',
        },
        -- Options which control scope computation
        options = {
          -- Type of scope's border: which line(s) with smaller indent to
          -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
          border = 'both',
          -- Whether to use cursor column when computing reference indent.
          -- Useful to see incremental scopes with horizontal cursor movements.
          indent_at_cursor = true,
          -- Whether to first check input line to be a border of adjacent scope.
          -- Use it if you want to place cursor on function header to get scope of
          -- its body.
          try_as_border = false,
        },
        -- Which character to use for drawing scope indicator
        symbol = '╎',
      }
      require('mini.indentscope').setup(opts)
    end,
  },
}
