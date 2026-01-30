-- LSP reference: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

local servers = require("extensions.lsp.servers")

for _, server in ipairs(servers) do
    local has_custom_opts, server_opts = pcall(require, "extensions.lsp.settings." .. server)
    local opts = vim.tbl_deep_extend("force", vim.lsp.config[server] or {}, has_custom_opts and server_opts or {})
    vim.lsp.config(server, opts)
end

vim.lsp.inlay_hint.enable(false)
vim.lsp.enable(servers)

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
