local M = {}

function M.kclfmt()
    return {
        exe = "kcl",
        args = { "fmt" },
    }
end

return M
