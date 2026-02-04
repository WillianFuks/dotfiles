return {
  {
    'LunarVim/primer.nvim',
    enabled = false,
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd('colorscheme primer_dark')
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme catppuccin-mocha')
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    enabled = true,
    config = function()
      require('kanagawa').setup()
      vim.cmd('colorscheme kanagawa-wave')
      -- vim.cmd('colorscheme kanagawa-dragon')
      -- vim.cmd('colorscheme kanagawa-lotus')
    end,
  },
  {
    'projekt0n/github-nvim-theme',
    enabled = false,
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('github-theme').setup()

      vim.cmd('colorscheme github_dark')
      -- vim.cmd('colorscheme github_dark_default')
      -- vim.cmd('colorscheme github_dark_high_contrast')
    end,
  },
  {
    'navarasu/onedark.nvim',
    priority = 1000, -- make sure to load this before all the other start plugins
    enabled = false,
    config = function()
      require('onedark').setup({
        style = 'warm',
      })
      -- Enable theme
      require('onedark').load()
    end,
  },
}
