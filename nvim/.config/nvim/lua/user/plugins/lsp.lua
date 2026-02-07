return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      {
        'j-hui/fidget.nvim',
        opts = {},
      },
      {
        'folke/neodev.nvim',
        enabled = true,
        opts = {},
      },
      {
        'SmiteshP/nvim-navic',
        enabled = false,
        lazy = true,
        opts = function()
          return {
            separator = ' ',
            highlight = true,
            depth_limit = 8,
            lazy_update_context = true,
          }
        end,
      },
    },
    opts = {
      diagnostics = {
        underline = false,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = 'if_many',
          prefix = '●',
        },
        float = {
          source = 'always',
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.HINT] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
          },
        },
      },
      inlay_hints = {
        enabled = true,
      },
      codelens = {
        enabled = false,
      },
      capabilities = {},
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      servers = {
        terraformls = {},
        yamlls = {
          -- Have to add this for yamlls to understand that we support line folding
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
          -- lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.yaml.schemas = vim.tbl_deep_extend(
              'force',
              new_config.settings.yaml.schemas or {},
              require('schemastore').yaml.schemas()
            )
          end,
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              keyOrdering = false,
              format = {
                enable = true,
              },
              validate = true,
              schemaStore = {
                -- Must disable built-in schemaStore support to use
                -- schemas from SchemaStore.nvim plugin
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = '',
              },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = {
                disable = { 'missing-fields' },
                globals = { 'vim' },
              },
            },
          },
        },
        basedpyright = {
          -- typeCheckingMode = 'standard',
        },
        ['eslint-lsp'] = {},
        ['css-lsp'] = {},
        jsonls = {
          -- lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require('schemastore').json.schemas())
          end,
          settings = {
            json = {
              format = {
                enable = true,
              },
              validate = { enable = true },
            },
          },
        },
      },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp_attached', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [d]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('gy', require('telescope.builtin').lsp_type_definitions, 'T[y]pe definition')
          -- Fuzzy find all the symbols in current document.
          -- Symbols are things like variables, functions, types, etc.
          map('<leader>ls', require('telescope.builtin').lsp_document_symbols, '[L]SP [S]ymbols')
          -- Fuzzy find all the symbols in your current workspace.
          -- Similar to document symbols, except searches over your entire project.
          map('<leader>lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[L]SP [W]orkspace symbols')
          -- Rename the variable under your cursor.
          map('<leader>lr', vim.lsp.buf.rename, '[L]SP [R]ename')
          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>la', vim.lsp.buf.code_action, '[L]SP code [A]ction')
          -- Opens a popup that displays documentation about the word under your cursor
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          -- WARN: This is not Goto Definition, this is Goto Declaration.
          -- For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gl', function()
            local float = vim.diagnostic.config().float
            if float then
              local config = type(float) == 'table' and float or {}
              config.scope = 'line'
              vim.diagnostic.open_float(config)
            end
          end, 'Show line diagnostics')

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client.name == 'yamlls' then
            client.server_capabilities.documentFormattingProvider = true
          end

          -- code lens
          if opts.codelens.enabled and vim.lsp.codelens then
            if client.supports_method('textDocument/codeLens') then
              vim.lsp.codelens.refresh()
              vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
                buffer = event.buf,
                callback = vim.lsp.codelens.refresh,
              })
            end
          end
          -- inlay hints
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>li', function()
              vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
            end, '[L]SP toggle [I]nlay hints')
          end
          -- navic
          local ok, navic = pcall(require, 'nvim-navic')
          if ok then
            if client.server_capabilities.documentSymbolProvider then
              navic.attach(client, event.buf)
            end
            if require('nvim-navic').is_available() then
              vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
            end
          end
        end,
      })

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(opts.servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
      })
      require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, win_opts, ...)
        local wopts = win_opts or {}
        wopts.border = wopts.border or 'rounded'
        return orig_util_open_floating_preview(contents, syntax, win_opts, ...)
      end

      require('mason-lspconfig').setup({
        handlers = {
          function(server_name)
            if server_name == 'tsserver' then
              return
            end
            local server = opts.servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
        ['tsserver'] = function()
          -- Skip since we use typescript-tools.nvim
        end,
      })
    end,
  },
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      luasnip.config.setup({})

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        preselect = cmp.PreselectMode.None,
        experimental = {
          ghost_text = false,
          native_menu = false,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        completion = { completeopt = 'menu,menuone,noselect' },
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<C-Space>'] = cmp.mapping.complete({}),
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      })
    end,
  },
  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    dependencies = { 'mason.nvim' },
    keys = {
      {
        '<leader>lf',
        function()
          require('conform').format({ async = true, lsp_fallback = true })
        end,
        mode = { 'n', 'v' },
        desc = '[L]SP [F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = true,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = function(bufnr)
          if require('conform').get_formatter_info('ruff_format', bufnr).available then
            return { 'ruff_format', 'isort' }
          else
            return { 'isort', 'flake8' }
          end
        end,
        sh = { 'shfmt' },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        yaml = { 'prettierd', 'prettier', stop_after_first = true },
        sql = { 'sqlfmt' },
      },
    },
  },
  {
    'stevearc/aerial.nvim',
    event = 'VeryLazy',
    opts = {
      attach_mode = 'global',
      backends = { 'lsp', 'treesitter', 'markdown', 'man' },
      show_guides = true,
      layout = {
        resize_to_content = false,
        win_opts = {
          winhl = 'Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB',
          signcolumn = 'yes',
          statuscolumn = ' ',
        },
      },
      guides = {
        mid_item = '├╴',
        last_item = '└╴',
        nested_top = '│ ',
        whitespace = '  ',
      },
    },
    keys = {
      { '<leader>a', '<cmd>AerialToggle<cr>', desc = '[A]erial (Symbols)' },
    },
  },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },
}
