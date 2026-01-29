local mason = require("extensions.mason.packages")

require("mason").setup({
    install_root_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "mason"),
    max_concurrent_installers = 5,
    PATH = "skip",
    log_level = vim.log.levels.INFO,
    pip = {
        upgrade_pip = false,
    },
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})

require("mason-lspconfig").setup({
    automatic_enable = false,
    ensure_installed = mason.PACKAGES,
})

require("mason-tool-installer").setup({
    ensure_installed = mason.INSTALLER_PACKAGES,
    run_on_start = #vim.api.nvim_list_uis() > 0,
})
