require("noice").setup({
    cmdline = {
        view = "cmdline",
    },
    popupmenu = {
        enabled = false,
    },
    signature = {
        enabled = false,
    },
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
    },
    views = {
        confirm = {
            border = {
                style = "rounded",
                text = { top = {} },
            },
        },
    },
    routes = {
        {
            filter = { event = "msg_show", error = true, min_height = 5 },
            view = "split",
        },
        {
            filter = { event = "msg_show", find = "Type.*:qa!?.*" },
            opts = { skip = true },
        },
    },
    -- format = {
    --     notify = {
    --         "{level} ",
    --         "{date} ",
    --         "{event}",
    --         "{kind}",
    --         "-",
    --         "{title} ",
    --         "{cmdline} ",
    --         "{message}",
    --     },
    -- },
})
