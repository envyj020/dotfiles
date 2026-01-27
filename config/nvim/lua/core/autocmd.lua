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

-- Install missing Treesitter parser if any for a given buffer and turns it on
autocmd("Filetype", {
    group = group,
    pattern = "*",
    callback = function(e)
        local ok, nvim_treesitter = pcall(require, "nvim-treesitter")

        if not ok then
            return
        end

        local ft = vim.bo[e.buf].ft
        local treesitter_parsers = require("nvim-treesitter.parsers")
        local parser = vim.treesitter.language.get_lang(ft)

        if not treesitter_parsers[parser] then
            return
        end

        nvim_treesitter.install({ parser }):await(function(err)
            if err then
                vim.notify("Couldn't install Treesitter parser for filetype: " .. ft .. " error: " .. err)
                return
            end

            pcall(vim.treesitter.start, e.buf)
            vim.opt_local.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.opt_local.foldmethod = "expr"
            vim.opt_local.foldlevel = 100
        end)
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
        map("i", "<C-k>", vim.lsp.buf.signature_help, keymap_opts("Show signature definition", opts))
        map("n", "K", vim.lsp.buf.hover, keymap_opts("Show signature documentation", opts))

        -- LSP Diagnostics
        map("n", "<C-e>", function()
            vim.diagnostic.jump({ count = 1 })
        end, keymap_opts("Next diagnostic", opts))

        map("n", "<C-p>", function()
            vim.diagnostic.jump({ count = -1 })
        end, keymap_opts("Previous diagnostic", opts))

        local function show(subcommand)
            return command("Trouble", subcommand, "toggle")
        end

        -- LSP Navigation
        map("n", "<C-S-Left>", vim.lsp.buf.definition, keymap_opts("Go to definition", opts))
        map("n", "<C-S-Right>", vim.lsp.buf.declaration, keymap_opts("Go to declaration", opts))
        map("n", "<Leader>sa", vim.lsp.buf.code_action, keymap_opts("Code actions", opts))

        map("n", "<Leader>sd", show("diagnostics"), keymap_opts("Search diagnostics", opts))
        map("n", "<Leader>sra", show("lsp"), keymap_opts("LSP ref,def,dec,impl", opts))
        map("n", "<Leader>sde", show("lsp_definitions"), keymap_opts("LSP definitions", opts))
        map("n", "<Leader>sr", show("lsp_references"), keymap_opts("LSP references", opts))
        map("n", "<Leader>sff", show("symbols"), keymap_opts("LSP document symbols", opts))
        map("n", "<Leader>sic", show("lsp_incoming_calls"), keymap_opts("LSP incoming calls", opts))
        map("n", "<Leader>soc", show("lsp_outgoing_calls"), keymap_opts("LSP outgoing calls", opts))
        map("n", "<Leader>si", show("lsp_implementations"), keymap_opts("LSP implementations", opts))
    end,
})
