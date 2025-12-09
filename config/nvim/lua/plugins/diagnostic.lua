-- Show diagnostic when hovering
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

local highlights = {
  DiagnosticLineError = { bg = "#311b2d" },
  DiagnosticLineWarn  = { bg = "#33291d" },
  DiagnosticLineHint  = { bg = "#1b2e33" },
  DiagnosticLineInfo  = { bg = "#1e2e20" },
  DiagnosticNrError   = { fg = "#ff6b6b" },
  DiagnosticNrWarn    = { fg = "#f0ad4e" },
  DiagnosticNrHint    = { fg = "#4fc3f7" },
  DiagnosticNrInfo    = { fg = "#81c784" },
}

for name, opts in pairs(highlights) do
  vim.api.nvim_set_hl(0, name, opts)
end

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticNrError",
            [vim.diagnostic.severity.WARN] = "DiagnosticNrWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticNrInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticNrHint",
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticLineError",
            [vim.diagnostic.severity.WARN] = "DiagnosticLineWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticLineInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticLineHint",
        },
    },
})

-- https://github.com/folke/trouble.nvim/blob/main/lua/trouble/view/window.lua
local window = {
    ["common"] = {
        type = "split",
        position = "bottom",
        size = 0.3,
    },
    ["preview"] = {
        size = { width = 0.3, height = 0.3 },
        position = { -5, -10 },
        type = "float",
        relative = "editor",
        border = "rounded",
        zindex = 200,
    },
}

require("trouble").setup({
    auto_close = false,
    auto_open = false,
    auto_preview = true,
    auto_refresh = true,
    auto_jump = true,
    focus = true,
    restore = true,
    follow = true,
    indent_guides = true,
    max_items = 200,
    multiline = true,
    pinned = false,
    warn_no_results = true,
    open_no_results = false,
    win = window.common,
    preview = {
        type = "main",
        scratch = true,
    },
    throttle = {
        refresh = 20,
        update = 10,
        render = 10,
        follow = 100,
        preview = { ms = 100, debounce = true },
    },
    keys = {
        ["<Tab>"] = "fold_toggle",
    },
    modes = {
        diagnostics = {
            mode = "diagnostics",
            preview = vim.tbl_deep_extend("force", window.preview or {}, {
                title = "Preview",
                title_pos = "center",
            }),
        },
        lsp_references = {
            params = {
                include_declaration = true,
            },
        },
        lsp_base = {
            params = {
                include_current = false,
            },
        },
        symbols = {
            mode = "lsp_document_symbols",
            focus = true,
            win = window.common,
            filter = {
                ["not"] = function(item)
                    local excluded_by_filetype = {
                        ["lua"] = { "Package" },
                        ["sh"] = { "Variable", "Constant" },
                    }
                    local filetype = vim.bo[item.buf].filetype
                    local excluded = excluded_by_filetype[filetype] or {}
                    return vim.tbl_contains(excluded, item.kind)
                end,
                any = {
                    kind = {
                        "Class",
                        "Constructor",
                        "Constant",
                        "Enum",
                        "Field",
                        "Function",
                        "Interface",
                        "Method",
                        "Module",
                        "Namespace",
                        "Package",
                        "Property",
                        "Struct",
                        "Trait",
                    },
                },
            },
        },
    },
    icons = {
        indent = {
            top = "│ ",
            middle = "├╴",
            last = "└╴",
            fold_open = " ",
            fold_closed = " ",
            ws = "  ",
        },
        folder_closed = " ",
        folder_open = " ",
        kinds = {
            Array = " ",
            Boolean = "󰨙 ",
            Class = " ",
            Constant = "󰏿 ",
            Constructor = " ",
            Enum = " ",
            EnumMember = " ",
            Event = " ",
            Field = " ",
            File = " ",
            Function = "󰊕 ",
            Interface = " ",
            Key = " ",
            Method = "󰊕 ",
            Module = " ",
            Namespace = "󰦮 ",
            Null = " ",
            Number = "󰎠 ",
            Object = " ",
            Operator = " ",
            Package = " ",
            Property = " ",
            String = " ",
            Struct = "󰆼 ",
            TypeParameter = " ",
            Variable = "󰀫 ",
        },
    },
})
