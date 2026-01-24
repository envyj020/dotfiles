local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local group = augroup("AwesomeNeovim", { clear = true })

-- Reload buffer if it was changed externally
autocmd("CursorHold", {
    group = group,
    pattern = "*",
    callback = function()
        if vim.fn.getcmdwintype() == "" and vim.bo.buftype == "" and vim.fn.mode() == "n" then
            vim.cmd("checktime")
        end
    end,
})

-- Disables comment wrapping
autocmd("FileType", {
    group = group,
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- Restores shada cursor position
autocmd("BufReadPost", {
    group = group,
    pattern = "*",
    callback = function()
        local prev_pos = vim.fn.line([['"]])
        local num_lines = vim.fn.line("$")

        if prev_pos > 1 and prev_pos <= num_lines then
            vim.cmd('normal! g`"')
        end
    end,
})

-- Set LSP keybindings on supported buffers
autocmd("LspAttach", {
    group = group,
    callback = function(e)
        local common = require("common")
        local keymap_opts = common.keymap_opts
        local command = common.command
        local map = vim.keymap.set
        local opts = { buffer = e.buf }

        -- LSP Signatures
        map("n", "<C-S-Left>", vim.lsp.buf.definition, keymap_opts("Go to definition", opts))
        map("n", "<C-S-Right>", vim.lsp.buf.declaration, keymap_opts("Go to declaration", opts))
        map("i", "<C-k>", vim.lsp.buf.signature_help, keymap_opts("Show signature definition", opts))
        map("n", "K", vim.lsp.buf.hover, keymap_opts("Show signature documentation", opts))

        -- LSP Diagnostics
        map("n", "<C-e>", function()
            vim.diagnostic.jump({ count = 1 })
        end, keymap_opts("Next diagnostic", opts))

        map("n", "<C-p>", function()
            vim.diagnostic.jump({ count = -1 })
        end, keymap_opts("Previous diagnostic", opts))

        -- LSP Navigation
        map("n", "<Leader>sa", vim.lsp.buf.code_action, keymap_opts("Code actions", opts))

        map("n", "<Leader>sd", command("Trouble", "diagnostics", "toggle"), keymap_opts("Search diagnostics", opts))
        map("n", "<Leader>sra", command("Trouble", "lsp", "toggle"), keymap_opts("LSP ref,def,dec,impl", opts))
        map("n", "<Leader>sde", command("Trouble", "lsp_definitions", "toggle"), keymap_opts("LSP definitions", opts))
        map("n", "<Leader>sr", command("Trouble", "lsp_references", "toggle"), keymap_opts("LSP references", opts))
        map("n", "<Leader>sff", command("Trouble", "symbols", "toggle"), keymap_opts("LSP document symbols", opts))
        map(
            "n",
            "<Leader>sic",
            command("Trouble", "lsp_incoming_calls", "toggle"),
            keymap_opts("LSP incoming calls", opts)
        )
        map(
            "n",
            "<Leader>soc",
            command("Trouble", "lsp_outgoing_calls", "toggle"),
            keymap_opts("LSP outgoing calls", opts)
        )
        map(
            "n",
            "<Leader>si",
            command("Trouble", "lsp_implementations", "toggle"),
            keymap_opts("LSP implementations", opts)
        )
    end,
})
