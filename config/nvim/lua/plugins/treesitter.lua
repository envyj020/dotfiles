require("nvim-treesitter").setup({
    install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "treesitter"),
})

require("nvim-treesitter").install(require("extensions.treesitter.parsers"))

require("nvim-treesitter-textobjects").setup({
    lookahead = true,
    move = { set_jumps = true },
})

require("treesitter-context").setup({
    max_lines = 10,
    multiline_threshold = 5,
})
