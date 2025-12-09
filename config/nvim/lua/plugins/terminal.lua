local palette = require("catppuccin.palettes").get_palette("mocha")

require("toggleterm").setup({
    direction = "float",
    start_in_insert = true,
    float_opts = {
        border = "curved",
        width = 150,
    },
    persist_size = true,
    persist_mode = true,
    highlights = {
        FloatBorder = {
            guifg = palette.surface2,
        },
    },
})
