-- Package registry: https://mason-registry.dev/registry
-- Only packages in the registry including neovim:lspconfig are supported
-- https://github.com/mason-org/mason-lspconfig.nvim/blob/main/lua/mason-lspconfig/mappings.lua#L15

local common = require("common")

local MASON_UNSUPPORTED_LSP_PACKAGES = {
    "gh-actions-language-server",
}

local MASON_UNSUPPORTED_LINTER_PACKAGES = {
    "yamllint",
    "actionlint",
    "ansible-lint",
    "stylelint",
    "markdownlint",
    "markdownlint-cli2",
    "golangci-lint",
    "shellcheck",
    "tombi",
}

local MASON_UNSUPPORTED_FORMATTER_PACKAGES = {
    "prettier",
    "prettierd",
    "stylua",
    "shfmt",
    "goimports",
    "gotestsum",
    "golines",
    "json-to-struct",
}

local MASON_UNSUPPORTED_DAP_PACKAGES = {
    "debugpy",
    "delve",
    "bash-debug-adapter",
    "kotlin-debug-adapter",
    "js-debug-adapter",
    "php-debug-adapter",
}

local MASON_SUPPORTED_PACKAGES = {
    "yamlls",
    "bashls",
    "ansiblels",
    "dockerls",
    "terraformls",
    "gopls@v0.18.1",
    "astro",
    "mdx_analyzer",
    "lua_ls",
    "emmet_ls",
    "pyright",
    "vimls",
    "tflint",
    "ruff",
    "kcl",
}

local MASON_INSTALLER_PACKAGES = common.concat_tables(
    MASON_UNSUPPORTED_LSP_PACKAGES,
    MASON_UNSUPPORTED_LINTER_PACKAGES,
    MASON_UNSUPPORTED_FORMATTER_PACKAGES,
    MASON_UNSUPPORTED_DAP_PACKAGES
)

return {
    PACKAGES = MASON_SUPPORTED_PACKAGES,
    INSTALLER_PACKAGES = MASON_INSTALLER_PACKAGES,
}
