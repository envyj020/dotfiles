local palette = require("catppuccin.palettes").get_palette("mocha")

vim.o.winwidth = 5
vim.o.winminwidth = 5
vim.o.equalalways = false

vim.api.nvim_set_hl(0, "mocha_window_picker", {
    fg = palette.text,
    bg = palette.mantle,
    bold = true,
    reverse = false,
})

require("nvim-window").setup({
    render = "float",
    normal_hl = "mocha_window_picker",
    border = "none",
})

require("windows").setup({
    animation = {
        enable = true,
        duration = 150,
        fps = 60,
        easing = "in_out_sine",
    },
})

require("neoscroll").setup({
    easing = "linear",
    mappings = {},
})

require("smart-splits").setup({
    ignored_buftypes = {
        "nofile",
        "quickfix",
        "prompt",
    },
    default_amount = 5,
    ignored_events = {
        "BufEnter",
        "WinEnter",
    },
})

require("winmove").configure({
    modes = {
        move = {
            keymaps = {
                left = "<left>",
                down = "<down>",
                up = "<up>",
                right = "<right>",
                far_left = "<S-left>",
                far_down = "<S-down>",
                far_up = "<S-up>",
                far_right = "<S-right>",
            },
        },
    },
})
