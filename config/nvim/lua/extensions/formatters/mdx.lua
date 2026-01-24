local M = {}

function M.prettierd()
    return {
        exe = "prettierd",
        args = { vim.fn.shellescape(vim.api.nvim_buf_get_name(0), true) },
        stdin = true,
    }
end

return M
