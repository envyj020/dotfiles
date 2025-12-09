local telescope = require("telescope")
local actions = require("telescope.actions")

local highlights = {
    TelescopeSelection = { fg = "#ff38a2", bold = true },
    TelescopeMatching = { fg = "#d9bcef" },
}

for name, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, name, opts)
end

telescope.setup({
    defaults = {
        border = true,
        results_title = false,
        prompt_title = false,
        dynamic_preview_title = false,
        layout_strategy = "horizontal",
        scroll_strategy = "cycle",
        sorting_strategy = "descending",
        layout_config = {
            horizontal = {
                prompt_position = "bottom",
                preview_width = 0.5,
                results_width = 0.5,
                padding = { 0, 0, 0, 0 },
            },
            vertical = {
                preview_width = 0.5,
                results_width = 0.5,
                prompt_position = "bottom",
                padding = { 0, 0, 0, 0 },
            },
        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--ignore",
            "--hidden",
        },
        file_ignore_patterns = {
            ".git",
            "vendor",
            "node_modules",
        },
        prompt_prefix = "🔎 ",
        mappings = {
            i = {
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,
                ["<C-x>"] = actions.file_split,
                ["<C-v>"] = actions.file_vsplit,
                ["<C-t>"] = actions.file_tab,
                ["<esc>"] = actions.close,
            },
        },
    },
    pickers = {
        buffers = {
            theme = "dropdown",
        },
        diagnostics = {
            theme = "ivy",
        },
        find_files = {
            find_command = { "rg", "--ignore", "--hidden", "--files" },
            theme = "ivy",
        },
        git_status = {
            theme = "ivy",
        },
        git_commits = {
            theme = "ivy",
        },
        grep_string = {
            theme = "ivy",
        },
        lsp_document_symbols = {
            theme = "ivy",
        },
        lsp_incoming_calls = {
            theme = "ivy",
        },
        lsp_outgoing_calls = {
            theme = "ivy",
        },
        lsp_code_actions = {
            theme = "cursor",
        },
        lsp_workspace_diagnostics = {
            theme = "dropdown",
        },
        live_grep = {
            theme = "ivy",
        },
        old_files = {
            theme = "ivy",
        },
        help_tags = {
            theme = "ivy",
        },
        keymaps = {
            theme = "ivy",
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
        },
    },
})

local extensions = {
    "ui-select",
    "fzf",
}

for _, extension in pairs(extensions) do
    telescope.load_extension(extension)
end
