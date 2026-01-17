local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local group = augroup("AwesomeNeovim", { clear = true })

-- Reload buffer if it was changed externally
autocmd("CursorHold", {
    group = group,
    pattern = "*",
    command = "checktime",
})

-- Disables comment wrapping
autocmd("filetype", {
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
