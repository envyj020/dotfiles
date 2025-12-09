local highlights = {
    MatchParen = { bg = "#87c095", bold = true },
    LinrNr = {},
}

for name, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, name, opts)
end
