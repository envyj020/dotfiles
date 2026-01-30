require("lint").linters_by_ft = {
    gha = { "actionlint" },
    markdown = { "markdownlint" },
    css = { "stylelint" },
    python = { "ruff" },
    yaml = { "yamllint" },
    json = { "jq" },
    toml = { "tombi" },
    go = { "golangcilint" },
}
