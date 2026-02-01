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

-- Replicates Treesitter master branch auto_install feature
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
                vim.notify(
                    "Couldn't install Treesitter parser for filetype: " .. ft .. " error: " .. err,
                    vim.log.levels.ERROR
                )
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

-- Linter
autocmd({ "BufEnter", "BufWritePost" }, {
    group = group,
    callback = function()
        local ok, lint = pcall(require, "lint")
        if not ok then
            return
        end
        lint.try_lint()
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
        map("i", "<C-k>", vim.lsp.buf.signature_help, keymap_opts("LSP: show signature definition", opts))
        map("n", "K", vim.lsp.buf.hover, keymap_opts("LSP: show signature documentation", opts))

        -- LSP Diagnostics
        map("n", "<C-e>", function()
            vim.diagnostic.jump({ count = 1 })
        end, keymap_opts("LSP: next diagnostic", opts))

        map("n", "<C-p>", function()
            vim.diagnostic.jump({ count = -1 })
        end, keymap_opts("LSP: previous diagnostic", opts))

        -- LSP Navigation
        local function toggle(subcommand)
            return command("Trouble", subcommand, "toggle")
        end

        map("n", "<C-S-Left>", vim.lsp.buf.definition, keymap_opts("LSP: go to definition", opts))
        map("n", "<C-S-Right>", vim.lsp.buf.declaration, keymap_opts("LSP: go to declaration", opts))
        map("n", "<Leader>sa", vim.lsp.buf.code_action, keymap_opts("LSP: code actions", opts))

        map("n", "<Leader>sd", toggle("diagnostics"), keymap_opts("LSP: Search diagnostics", opts))
        map("n", "<Leader>sra", toggle("lsp"), keymap_opts("LSP: search *", opts))
        map("n", "<Leader>sde", toggle("lsp_definitions"), keymap_opts("LSP: definitions", opts))
        map("n", "<Leader>sr", toggle("lsp_references"), keymap_opts("LSP: references", opts))
        map("n", "<Leader>sff", toggle("symbols"), keymap_opts("LSP: document symbols", opts))
        map("n", "<Leader>sic", toggle("lsp_incoming_calls"), keymap_opts("LSP: incoming calls", opts))
        map("n", "<Leader>soc", toggle("lsp_outgoing_calls"), keymap_opts("LSP: outgoing calls", opts))
        map("n", "<Leader>si", toggle("lsp_implementations"), keymap_opts("LSP: implementations", opts))
    end,
})
