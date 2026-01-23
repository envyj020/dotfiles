require("inc_rename").setup({
    input_buffer_type = "snacks",
    preview_empty_name = false,
    save_in_cmdline_history = false,
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

local bookmark_signs = { "", "⚡", "", "", "", "", "", "", "", "" }
local bookmark_opts = {}

for i, sign in ipairs(bookmark_signs) do
    local index = (i - 1)
    bookmark_opts["bookmark_" .. index] = {
        sign = sign,
        virt_text = "Bookmark: " .. index,
    }
end

require("marks").setup(bookmark_opts)
