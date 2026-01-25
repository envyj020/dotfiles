local catppuccin = require("catppuccin.palettes").get_palette("mocha")

local highlights = {
    TreesitterContextBottom = { fg = catppuccin.rosewater, bg = catppuccin.base, underline = false, bold = true },
    MatchParen = { fg = catppuccin.green, bold = true },
    CurSearch = { fg = catppuccin.base, bg = catppuccin.peach },
    LineNr = { fg = catppuccin.surface1 },
}

for name, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, name, opts)
end
