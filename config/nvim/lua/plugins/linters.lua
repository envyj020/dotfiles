local lint = require("lint")

lint.linters_by_ft = {
    gha = { "actionlint" },
    markdown = { "markdownlint" },
    python = { "ruff" },
    yaml = { "yamllint" },
    json = { "jq" },
    toml = { "tombi" },
    go = { "golangcilint" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("lint", { clear = true }),
    callback = function()
        lint.try_lint()
    end,
})
