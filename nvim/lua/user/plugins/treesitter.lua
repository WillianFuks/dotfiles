return {
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    event = { 'VeryLazy' },
    init = function(plugin)
      require('lazy.core.loader').add_to_rtp(plugin)
      require('nvim-treesitter.query_predicates')
    end,
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-context',
        event = 'VeryLazy',
        enabled = false,
        opts = {
          enable = true,
          max_lines = 1,
          min_window_height = 0,
          line_numbers = true,
          multiline_threshold = 1,
          trim_scope = 'inner',
          mode = 'cursor',
          separator = '',
          zindex = 20,
          on_attach = nil,
        },
        config = function(_, opts)
          vim.cmd('hi TreesitterContextBottom gui=underline guisp=Grey guibg=#283642')
          require'treesitter-context'.setup(opts)
        end,
      },
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        event = 'VeryLazy',
        opts = {
          textobjects = {
            select = {
              enable = true,
              lookahead = true,
              keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
                ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
              },
              selection_modes = {
                ['@parameter.outer'] = 'v', -- charwise
                ['@function.outer'] = 'V', -- linewise
                ['@class.outer'] = '<c-v>', -- blockwise
              },
              include_surrounding_whitespace = false,
            },
          },
        },
        config = function(_, opts)
          require('nvim-treesitter.configs').setup(opts)
        end,
      },
    },
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
    opts = {
      auto_install = true,
      highlight = {
        enable = true,
        disable = function(_, buf)
          local max_filesize = 100 * 1024 -- 100 KiB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<C-S-space>',
        },
      },
      indent = { enable = true },
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'jsonc',
        'lua',
        'luadoc',
        'luap',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'regex',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'xml',
        'yaml',
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.install').prefer_git = true

      vim.cmd('set foldmethod=expr')
      vim.cmd('set foldexpr=nvim_treesitter#foldexpr()')
      vim.cmd('set nofoldenable')

      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    opts = {},
    ft = {
      'html',
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
      'svelte',
      'vue',
      'tsx',
      'jsx',
      'rescript',
      'xml',
      'php',
      'markdown',
      'astro',
      'glimmer',
      'handlebars',
      'hbs',
    },
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },
}
