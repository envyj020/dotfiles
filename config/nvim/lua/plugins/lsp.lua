-- LSP reference: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

local LSP_SERVERS = {
    "bashls",
    "yamlls",
    "ansiblels",
    "dockerls",
    "pyright",
    "kcl",
    "gopls",
    "terraformls",
    "vimls",
    "lua_ls",
    "gh_actions_ls",
    "tombi",
}

for _, server in ipairs(LSP_SERVERS) do
    local has_custom_opts, server_opts = pcall(require, "extensions.lsp-settings." .. server)
    local opts = has_custom_opts and server_opts or {}

    vim.lsp.config(server, opts)
end

vim.lsp.inlay_hint.enable(false)
vim.lsp.enable(LSP_SERVERS)

require("lsp_signature").setup({
    debug = false,
    verbose = false,
    bind = true,
    time_interval = 100,
    floating_window = false,
    hint_inline = function()
        return "eol"
    end,
    hint_enable = true,
    hint_prefix = {
        above = "↙ ",
        current = "← ",
        below = "↖ ",
    },
})
