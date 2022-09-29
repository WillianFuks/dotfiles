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
    char = "▏",
    show_trailing_blankline_indent = true,
    show_first_indent_level = false,
    use_treesitter = true,
    show_current_context = true,
    use_treesitter_scope = true,
    show_current_context_start = false
}

require('indent_blankline').setup(config)
