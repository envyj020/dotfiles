local M = {}

local CATPPUCCIN_EXTENDED_THEME = {
    latte = {
        info = "#e0e5eb",
        hint = "#d5dae0",
        warn = "#f0e5d5",
        err = "#33293a",
        darkblue = "#d4e0f5",
        violet = "#dcd6f5",
        magenta = "#ead6f5",
    },
    frappe = {
        info = "#3a4555",
        hint = "#354050",
        warn = "#4a3d2a",
        err = "#4a2d3d",
        darkblue = "#1a2a45",
        violet = "#baaaf0",
        magenta = "#d688e8",
    },
    macchiato = {
        info = "#293141",
        hint = "#2a323f",
        warn = "#33291d",
        err = "#311b2d",
        darkblue = "#0c1f3a",
        violet = "#b4a7e6",
        magenta = "#d280e3",
    },
    mocha = {
        info = "#293141",
        hint = "#2a323f",
        warn = "#34323b",
        err = "#311b2d",
        darkblue = "#081633",
        violet = "#a9a1e1",
        magenta = "#c678dd",
    },
}

local CATPPUCCIN_THEMES = vim.tbl_keys(CATPPUCCIN_EXTENDED_THEME)

function M.get(name)
    name = vim.tbl_contains(CATPPUCCIN_THEMES, name) and name or vim.g.catppuccin_theme

    local base = require("catppuccin.palettes").get_palette(name)
    return vim.tbl_extend("keep", base, CATPPUCCIN_EXTENDED_THEME[name])
end

return M
