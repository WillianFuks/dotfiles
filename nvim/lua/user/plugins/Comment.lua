local config = { 
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
        ---Line-comment toggle keymap
        line = '<leader>c',
        ---Block-comment toggle keymap
        block = '<leader>bc',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        ---Line-comment keymap
        line = '<leader>c',
        ---Block-comment keymap
        block = '<leader>bc',
    },
    ---Enable keybindings
    mappings = {
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = false,
        ---Extended mapping; `g>` `g<` `g>[count]{motion}` `g<[count]{motion}`
        extended = false,
    },
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

require('Comment').setup(config)
