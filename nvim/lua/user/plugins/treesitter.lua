local config = {
  ensure_installed = { },
  auto_install = true,
  ignore_install = { },
  matchup = {
    enable = false,
    disable_virtual_text = true,
    include_match_words = false,
  },
  autopairs = {
    enable = false
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = { 'latex' },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    config = {
      typescript = "// %s",
      css = "/* %s */",
      scss = "/* %s */",
      html = "<!-- %s -->",
      svelte = "<!-- %s -->",
      vue = "<!-- %s -->",
      json = "",
    },
  },
  indent = {
      enable = true,
      disable = { 'yaml', 'python' }
  },
  autotag = {
    enable = true
  },
  --textobjects = {},
  textsubjects = {
    enable = false,
    keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-big" },
  },
  --playground = { },
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than 1000 lines, int
  },
  refactor = {
    highlight_current_scope = { enable = false },
    highlight_definitions = {
      enable = false,
      clear_on_cursor_move = true
    },
    smart_rename = {
      enable = false,
      keymaps = {
        smart_rename = "grr",
      },
    },
  },
}

local treesitter_configs = require 'nvim-treesitter.configs'
treesitter_configs.setup(config)
