local config = {
    check_ts = true,
    ts_config = { },
}

local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

npairs.setup(config)
