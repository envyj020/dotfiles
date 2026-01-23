local renamer_u = require("renamer.mappings.utils")

require("renamer").setup({
    title = "Rename",
    padding = {
        top = 0,
        left = 0,
        bottom = 0,
        right = 0,
    },
    min_width = 15,
    max_width = 45,
    border = true,
    border_chars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    show_refs = true,
    with_qf_list = true,
    with_popup = true,

    --- @diagnostic disable-next-line: assign-type-mismatch
    mappings = {
        ["<c-i>"] = renamer_u.set_cursor_to_start,
        ["<c-a>"] = renamer_u.set_cursor_to_end,
        ["<c-e>"] = renamer_u.set_cursor_to_word_end,
        ["<c-b>"] = renamer_u.set_cursor_to_word_start,
        ["<c-c>"] = renamer_u.clear_line,
        ["<c-u>"] = renamer_u.undo,
        ["<c-r>"] = renamer_u.redo,
    },
    --- @diagnostic disable-next-line: assign-type-mismatch
    handler = nil,
})

require("colorizer").setup({
    user_default_options = {
        names = false,
        RRGGBBAA = true,
        AARRGGBB = true,
        rgb_fn = true,
        hsl_fn = true,
        mode = "virtualtext",
        virtualtext = "󱓻 ",
        virtualtext_inline = true,
        virtualtext_mode = "foreground",
    },
})

require("flash").setup({
    search = { multi_window = false },
    modes = { treesitter_search = { search = { multi_window = false } } },
})

require("schema-companion").setup({
    formatting = false,
    enable_telescope = true,
    matchers = {
        require("schema-companion.matchers.kubernetes").setup({ version = "v1.32.4" }),
    },
})

require("nvim-toc").setup({
    toc_header = "Table of contents",
})

require("render-markdown").setup({
    completions = { lsp = { enabled = true } },
    latext = { enabled = false },
    file_types = { "markdown", "Avante", "norg", "rmd", "org", "codecompanion", "quarto", "vimwiki" },
    render_modes = { "n", "c", "t" },
    heading = {
        position = "inline",
    },
})

require("cutlass").setup({
    cut_key = "x",
    registers = {
        select = "_",
        delete = "_",
        change = "_",
    },
})

require("cloak").setup({
    enabled = true,
    cloak_character = "*",
    patterns = {
        {
            file_pattern = ".env*",
            cloak_pattern = "=.+",
        },
        {
            file_pattern = { "*.yaml", "*.yml" },
            cloak_pattern = {
                "(value:%s*)(.+)",
                "(token:%s*)(.+)",
                "(stringData:%s*)(.+)",
            },
            replace = "%1",
        },
        {
            file_pattern = { "docker-compose.yaml", "docker-compose.yml" },
            cloak_pattern = {
                "([A-Z%-_]+%s*[:=]%s*)(.+)",
            },
            replace = "%1",
        },
    },
})
