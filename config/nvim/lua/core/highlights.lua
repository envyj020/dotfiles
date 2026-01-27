local catppuccin = require("extensions.palette").get(vim.g.catppuccin_theme)

local highlights = {
    DiagnosticLineError = { bg = catppuccin.err },
    DiagnosticLineWarn = { bg = catppuccin.warn },
    DiagnosticLineHint = { bg = catppuccin.hint },
    DiagnosticLineInfo = { bg = catppuccin.info },
    DiagnosticNrError = { fg = catppuccin.red },
    DiagnosticNrWarn = { fg = catppuccin.peach },
    DiagnosticNrHint = { fg = catppuccin.blue },
    DiagnosticNrInfo = { fg = catppuccin.green },
    TelescopeMatching = { fg = catppuccin.blue },
    TelescopeSelection = { fg = catppuccin.peach, bold = true },
    TelescopeSelectionCaret = { fg = catppuccin.peach, bg = catppuccin.mantle, bold = true },
    TreesitterContextBottom = { fg = catppuccin.rosewater, bg = catppuccin.base, underline = false, bold = true },
    WindowPicker = { fg = catppuccin.text, bg = catppuccin.mantle, bold = true, reverse = false },
    MatchParen = { fg = catppuccin.green, bold = true },
    CurSearch = { fg = catppuccin.base, bg = catppuccin.peach },
    LineNr = { fg = catppuccin.surface1 },
}

for name, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, name, opts)
end
