local skipped_servers = {
    'angularls',
    'ansiblels',
    'ccls',
    'csharp_ls',
    'cssmodules_ls',
    'denols',
    'ember',
    'emmet_ls',
    'eslint',
    'eslintls',
    'golangci_lint_ls',
    'graphql',
    'jedi_language_server',
    'ltex',
    'ocamlls',
    'phpactor',
    'psalm',
    'pylsp',
    'quick_lint_js',
    'rome',
    'reason_ls',
    'scry',
    'solang',
    'solidity_ls',
    'sorbet',
    'sourcekit',
    'sourcery',
    'spectral',
    'sqlls',
    'sqls',
    'stylelint_lsp',
    'tflint',
    'svlangserver',
    'verible',
    'vuels',
}

local skipped_filetypes = { 'markdown', 'rst', 'plaintext' }

local float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
    format = function(d)
        local code = d.code or (d.user_data and d.user_data.lsp.code)
        if code then
            return string.format('%s [%s]', d.message, code):gsub('1. ', '')
        end
        return d.message
    end,
}

local null_ls = require('null-ls')

return {
    diagnostics = {
        signs = {
            active = true,
            values = {
                { name = 'DiagnosticSignError', text = '' },
                { name = 'DiagnosticSignWarn', text = '' },
                { name = 'DiagnosticSignHint', text = '' },
                { name = 'DiagnosticSignInfo', text = '' },
            },
        },
        virtual_text = false,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = float,
    },
    float = {
        focusable = true,
        style = 'minimal',
        border = 'rounded',
    },
    automatic_configuration = {
        ---@usage list of servers that the automatic installer will skip
        skipped_servers = skipped_servers,
        ---@usage list of filetypes that the automatic installer will skip
        skipped_filetypes = skipped_filetypes,
    },
    buffer_mappings = {
        normal_mode = {
            ['K'] = { vim.lsp.buf.hover, 'Show hover' },
            ['gd'] = { vim.lsp.buf.definition, 'Goto Definition' },
            ['gD'] = { vim.lsp.buf.declaration, 'Goto declaration' },
            ['gr'] = { vim.lsp.buf.references, 'Goto references' },
            ['gI'] = { vim.lsp.buf.implementation, 'Goto Implementation' },
            ['gs'] = { vim.lsp.buf.signature_help, 'show signature help' },
            ['gq'] = { vim.diagnostic.setloclist, 'Opens loclist window' },
            ['gl'] = {
                function()
                    local config = float
                    config.scope = 'line'
                    vim.diagnostic.open_float(0, config)
                end,
                'Show line diagnostics',
            },
        },
    },
    buffer_autocmds = {
        codelens_group = 'lsp_code_lens_refresh',
    },
    nlsp_settings = {},
    null_ls = {
        sources = {
            null_ls.builtins.code_actions.refactoring,
            null_ls.builtins.code_actions.eslint_d.with({
                prefer_local = 'node_modules/.bin',
            }),

            null_ls.builtins.diagnostics.flake8.with({
                method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
            }),
            null_ls.builtins.diagnostics.cmake_lint.with({
                method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
            }),
            null_ls.builtins.diagnostics.eslint_d.with({
                method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
                prefer_local = 'node_modules/.bin',
            }),
            null_ls.builtins.diagnostics.luacheck.with({
                method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
                extra_args = { '--globals', 'vim' },
            }),
            null_ls.builtins.diagnostics.mypy.with({
                method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
            }),
            null_ls.builtins.diagnostics.pydocstyle.with({
                method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
            }),
            null_ls.builtins.diagnostics.shellcheck.with({
                method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
            }),
            -- null_ls.builtins.diagnostics.spectral,
            null_ls.builtins.diagnostics.stylelint.with({
                method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
            }),
            null_ls.builtins.diagnostics.tidy.with({
                method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
            }),
            null_ls.builtins.diagnostics.tsc.with({
                method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
            }),
            null_ls.builtins.diagnostics.vulture.with({
                method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
            }),
            null_ls.builtins.diagnostics.yamllint.with({
                method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
            }),
            null_ls.builtins.diagnostics.sqlfluff.with({
                method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
            }),

            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.beautysh,
            null_ls.builtins.formatting.eslint_d.with({
                prefer_local = 'node_modules/.bin',
            }),
            null_ls.builtins.formatting.fixjson,
            null_ls.builtins.formatting.isort,
            null_ls.builtins.formatting.prettierd.with({
                prefer_local = 'node_modules/.bin',
            }),
            null_ls.builtins.formatting.tidy,
            null_ls.builtins.formatting.trim_newlines,
            null_ls.builtins.formatting.trim_whitespace,
            null_ls.builtins.formatting.sqlfluff.with({
            }),
        },
    },
}
