-- LSP reference: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

local ENABLED_LSP_SERVERS = {
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
}

-- Turn off func arg virtual text hints
vim.lsp.inlay_hint.enable(false)

vim.lsp.config("gh_actions_ls", {
    filetypes = { "yaml.gha" },
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            workspace = {
                library = {
                    vim.env.VIMRUNTIME,
                },
            },
            diagnostics = {
                globals = { "vim" },
                disable = { "missing-fields", "undefined-field" },
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

local yamlcnf = require("schema-companion").setup_client({
    filetypes = {
        "yaml",
        "!yaml.ansible",
        "!yaml.docker-compose",
    },
    settings = {
        flags = {
            debounce_text_changes = 50,
        },
        redhat = { telemetry = { enabled = false } },
        yaml = {
            hover = true,
            completion = true,
            validate = true,
            format = { enable = false },
            schemaDownload = { enable = true },
            schemaStore = {
                enable = true,
                url = "https://www.schemastore.org/api/json/catalog.json",
            },
            schemas = {},
        },
    },
})

vim.lsp.config("yamlls", yamlcnf)

-- Enable LSPs
vim.lsp.enable(ENABLED_LSP_SERVERS)

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
