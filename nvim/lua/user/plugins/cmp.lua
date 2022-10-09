local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local cmp = require('cmp')
local luasnip = require('luasnip')

local max_width = 0
local kind_icons = {
    Class = ' ',
    Color = ' ',
    Constant = ' ',
    Constructor = ' ',
    Enum = '練',
    EnumMember = ' ',
    Event = ' ',
    Field = ' ',
    File = '',
    Folder = ' ',
    Function = ' ',
    Interface = ' ',
    Keyword = ' ',
    Method = ' ',
    Module = ' ',
    Operator = '',
    Property = ' ',
    Reference = ' ',
    Snippet = ' ',
    Struct = ' ',
    Text = ' ',
    TypeParameter = ' ',
    Unit = '塞',
    Value = ' ',
    Variable = ' ',
}

local source_names = {
    nvim_lsp = '[LSP]',
    emoji = '[Emoji]',
    path = '[Path]',
    calc = '[Calc]',
    cmp_tabnine = '[Tabnine]',
    vsnip = '[Snippet]',
    luasnip = '[Snippet]',
    buffer = '[Buffer]',
    tmux = '[TMUX]',
    npm = '[NPM]',
}

local duplicates = {
    buffer = 1,
    path = 1,
    nvim_lsp = 0,
    luasnip = 1,
}

local duplicates_default = 0
local confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
}

require('cmp-npm').setup({})

cmp.setup({
    confirm_opts = confirm_opts,
    completion = {
        ---@usage The minimum length of a word to complete on.
        keyword_length = 1,
    },
    experimental = {
        ghost_text = false,
        native_menu = false,
    },
    formatting = {
        fields = {'abbr', 'kind', 'menu' },
        max_width = max_width,
        kind_icons = kind_icons,
        source_names = source_names,
        duplicates = duplicates,
        duplicates_default = duplicates_default,
        format = function(entry, vim_item)
            if max_width ~= 0 and #vim_item.abbr > max_width then
                vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. '…'
            end
            vim_item.kind = table.concat({ kind_icons[vim_item.kind], ' ', vim_item.kind })
            vim_item.menu = source_names[entry.source.name]
            vim_item.dup = duplicates[entry.source.name] or duplicates_default
            return vim_item
        end,
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip' },
        { name = 'cmp_tabnine' },
        { name = 'nvim_lua' },
        { name = 'buffer' },
        { name = 'calc' },
        { name = 'emoji' },
        { name = 'treesitter' },
        { name = 'crates' },
        { name = 'tmux' },
        { name = 'npm', keyword_length = 2 },
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-y>'] = cmp.mapping({
            i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
            c = function(fallback)
                if cmp.visible() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                    fallback()
                end
            end,
        }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
    }),
})
