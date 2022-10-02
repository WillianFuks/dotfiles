local config = {
    ensure_installed = {},
    automatic_installation = true,
}

require("mason-lspconfig").setup(config)
