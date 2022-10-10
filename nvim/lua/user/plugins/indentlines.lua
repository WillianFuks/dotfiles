local config = {
    enabled = true,
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = {
        "help",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "text",
    },
    -- char = "▏",
    show_trailing_blankline_indent = true,
    show_first_indent_level = true,
    use_treesitter = true,
    show_current_context = false,
    use_treesitter_scope = true,
    show_current_context_start = true
}

require('indent_blankline').setup(config)
