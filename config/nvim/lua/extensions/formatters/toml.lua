local M = {}

function M.tombi()
    return {
        exe = "tombi",
        args = {
            "format",
            "--stdin-filename",
            vim.fn.shellescape(vim.api.nvim_buf_get_name(0), true),
            "-",
        },
        stdin = true,
    }
end

return M
