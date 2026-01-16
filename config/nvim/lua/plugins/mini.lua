require("mini.move").setup({
    mappings = {
        left = "<S-Tab>",
        right = "<Tab>",
        down = "<A-j>",
        up = "<A-k>",

        line_left = "<S-Tab>",
        line_right = "<Tab>",
        line_down = "<A-j>",
        line_up = "<A-k>",
    },

    options = {
        reindent_linewise = true,
    },
})

require("mini.bufremove").setup({
    silent = true,
})
