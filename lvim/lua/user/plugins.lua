-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.indentlines.options.use_treesitter = true
lvim.builtin.indentlines.options.context_char = lvim.icons.ui.LineLeft
lvim.builtin.indentlines.options.show_current_context = true
lvim.builtin.indentlines.options.show_first_indent_level = true
lvim.builtin.dap.active = true
lvim.builtin.illuminate.active = false
lvim.builtin.autopairs.active = false
lvim.builtin.nvimtree.setup.view.adaptive_size = true
lvim.builtin.nvimtree.setup.view.adaptive_size = true
lvim.builtin.nvimtree.setup.renderer.add_trailing = true

lvim.plugins = {
  {
    'phaazon/hop.nvim',
    config = function()
        local config = {
            keys = 'asdghklwertyuiopzxcvbnmfj',
            create_hl_autocmd = true,
            quit_key = 'q'
        }
        require('hop').setup(config)

        lvim.builtin.which_key.mappings["j"] = { "<cmd>HopWord<cr>", "Prepares for jumping anywhere in buffer to beginning of word" }
        vim.cmd([[hi HopNextKey1 guifg=#ff9900 gui=bold cterm=bold]])
        vim.cmd([[hi HopNextKey2 guifg=#ff9900 gui=bold cterm=bold]])
    end,
  },
  {
    "andymass/vim-matchup",
    setup = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "mrjones2014/nvim-ts-rainbow",
  },
  {
    "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
            RGB = true, -- #RGB hex codes
            RRGGBB = true, -- #RRGGBB hex codes
            RRGGBBAA = true, -- #RRGGBBAA hex codes
            rgb_fn = true, -- CSS rgb() and rgba() functions
            hsl_fn = true, -- CSS hsl() and hsla() functions
            css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
            css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
            })
    end,
  },
  {
    "tzachar/cmp-tabnine",
    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
    event = "InsertEnter",
  },
  {
    "rmagatti/goto-preview",
    config = function()
      require('goto-preview').setup {
        width = 120; -- Width of the floating window
        height = 25; -- Height of the floating window
        default_mappings = false; -- Bind default mappings
        debug = false; -- Print debug information
        opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
        -- You can use "default_mappings = true" setup option
        -- Or explicitly set keybindings
        -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
        -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
        -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
      }
    end
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require('symbols-outline').setup()
    end
  },
  {
    "folke/trouble.nvim",
      cmd = "TroubleToggle",
  },
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
    require('neoscroll').setup({
      -- All these keys will be mapped to their corresponding default scrolling animation
      mappings = {
        '<C-u>',
        '<C-d>',
        '<C-b>',
        '<C-f>',
        '<C-y>',
        '<C-e>',
        'zt',
        'zz',
        'zb'
      },
      hide_cursor = false,          -- Hide cursor while scrolling
      stop_eof = true,             -- Stop at <EOF> when scrolling downwards
      use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
      respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
      cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
      easing_function = nil,        -- Default easing function
      pre_hook = nil,              -- Function to run before the scrolling animation starts
      post_hook = nil,              -- Function to run after the scrolling animation ends
      })
    end
  },
  {
      "ethanholz/nvim-lastplace",
      event = "BufRead",
      config = function()
          require("nvim-lastplace").setup({
              lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
              lastplace_ignore_filetype = {
                  "gitcommit", "gitrebase", "svn", "hgcommit",
              },
              lastplace_open_folds = true,
          })
      end,
  },
}

lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.matchup.enable = true
lvim.builtin.treesitter.matchup.disable_virtual_text = false
lvim.builtin.treesitter.matchup.include_match_words = true
lvim.builtin.indentlines.options.show_current_context_start = true
lvim.builtin.telescope.pickers.previewer = true

-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }
