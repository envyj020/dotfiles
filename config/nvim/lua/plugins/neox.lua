require("neotest").setup({
    adapters = {
        require("neotest-golang")({
            runner = "gotestsum",
            filter_dir_patterns = {
                "**/vendor",
                "**/e2e",
            },
            env = {
                CGO_ENABLED = "1",
            },
        }),
        require("nvim-ginkgo"),
        require("neotest-python")({
            dap = { justMyCode = false },
        }),
    },
})

require("neogen").setup({
    enabled = true,
    snippet_engine = "vsnip",
    input_after_comment = true,
})

require("neoscroll").setup({
    easing = "linear",
    mappings = {},
})

require("neo-tree").setup({
    auto_clean_after_session_restore = true,
    close_if_last_window = true,
    source_selector = {
        winbar = true,
        statusline = false,
        truncation_character = "…",
        show_scrolled_off_parent_node = false,
        sources = {
            { source = "filesystem" },
            { source = "buffers" },
            { source = "git_status" },
        },
    },
    window = {
        position = "left",
        width = 40,
        mapping_options = {
            noremap = true,
            nowait = true,
        },
        mappings = {
            ["<space>"] = {
                "toggle_node",
                nowait = true,
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<esc>"] = "cancel",
            ["P"] = {
                "toggle_preview",
                config = {
                    use_float = true,
                    use_image_nvim = false,
                },
            },
            ["<C-f>"] = { "scroll_preview", config = { direction = -10 } },
            ["<C-b>"] = { "scroll_preview", config = { direction = 10 } },
            ["l"] = "focus_preview",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["w"] = "open_with_window_picker",
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            ["R"] = "refresh",
            ["a"] = { "add", config = {
                show_path = "none",
            } },
            ["A"] = "add_directory",
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy",
            ["m"] = "move",
            ["e"] = "toggle_auto_expand_width",
            ["q"] = "close_window",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
        },
    },
    filesystem = {
        filtered_items = {
            hide_dotfiles = false,
            hide_by_name = {
                "node_modules",
                "submodules",
            },
        },
        window = {
            mappings = {
                ["H"] = "toggle_hidden",
                ["/"] = "fuzzy_finder",
                ["D"] = "fuzzy_finder_directory",
                ["#"] = "fuzzy_sorter",
                ["f"] = "filter_on_submit",
                ["<C-x>"] = "clear_filter",
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
                ["[g"] = "prev_git_modified",
                ["]g"] = "next_git_modified",
                ["b"] = "rename_basename",
                ["oc"] = { "order_by_created", nowait = false },
                ["od"] = { "order_by_diagnostics", nowait = false },
                ["og"] = { "order_by_git_status", nowait = false },
                ["om"] = { "order_by_modified", nowait = false },
                ["on"] = { "order_by_name", nowait = false },
                ["os"] = { "order_by_size", nowait = false },
                ["ot"] = { "order_by_type", nowait = false },
            },
        },
    },
    buffers = {
        window = {
            mappings = {
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
                ["d"] = "buffer_delete",
                ["bd"] = "buffer_delete",
                ["i"] = "show_file_details",
                ["b"] = "rename_basename",
                ["oc"] = { "order_by_created", nowait = false },
                ["od"] = { "order_by_diagnostics", nowait = false },
                ["om"] = { "order_by_modified", nowait = false },
                ["on"] = { "order_by_name", nowait = false },
                ["os"] = { "order_by_size", nowait = false },
                ["ot"] = { "order_by_type", nowait = false },
            },
        },
    },
    git_status = {
        window = {
            mappings = {
                ["A"] = "git_add_all",
                ["gu"] = "git_unstage_file",
                ["ga"] = "git_add_file",
                ["gr"] = "git_revert_file",
                ["gc"] = "git_commit",
                ["gp"] = "git_push",
                ["gg"] = "git_commit_and_push",
                ["i"] = "show_file_details",
                ["b"] = "rename_basename",
                ["oc"] = { "order_by_created", nowait = false },
                ["od"] = { "order_by_diagnostics", nowait = false },
                ["om"] = { "order_by_modified", nowait = false },
                ["on"] = { "order_by_name", nowait = false },
                ["os"] = { "order_by_size", nowait = false },
                ["ot"] = { "order_by_type", nowait = false },
            },
        },
    },
})

require("neogit").setup({
    graph_style = "kitty",
})

require("gitsigns").setup({
    signs = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
    },
    signs_staged = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
    },
    signs_staged_enable = true,
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = {
        follow_files = true,
    },
    auto_attach = true,
    attach_to_untracked = false,
    current_line_blame = false,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 250,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
    },
    current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = 40000,
})

require("diffview").setup({
    use_icons = true,
    icons = {
        folder_closed = "",
        folder_open = "",
    },
    signs = {
        fold_closed = "",
        fold_open = "",
        done = "✓",
    },
    view = {
        -- :help diffview-layouts
        default = {
            layout = "diff2_horizontal",
            disable_diagnostics = false,
            winbar_info = false,
        },
        merge_tool = {
            layout = "diff3_mixed",
            disable_diagnostics = true,
            winbar_info = true,
        },
        file_history = {
            layout = "diff2_horizontal",
            disable_diagnostics = false,
            winbar_info = false,
        },
    },
})

require("gitgraph").setup({
    symbols = {
        merge_commit = "󱞳",
        commit = "",
        merge_commit_end = "",
        commit_end = "",
        GVER = "│",
        GHOR = "─",
        GCLD = "╮",
        GCRD = "╭",
        GCLU = "╯",
        GCRU = "╰",
        GLRU = "┴",
        GLRD = "┬",
        GLUD = "┤",
        GRUD = "├",
        GFORKU = "┼",
        GFORKD = "┼",
        GRUDCD = "├",
        GRUDCU = "├",
        GLUDCD = "┤",
        GLUDCU = "┤",
        GLRDCL = "┬",
        GLRDCR = "┬",
        GLRUCL = "┴",
        GLRUCR = "┴",
    },
    format = {
        timestamp = "%H:%M:%S %d-%m-%Y",
        fields = { "hash", "timestamp", "author", "branch_name", "tag" },
    },
    hooks = {
        on_select_commit = function(commit)
            vim.notify("Git Diff: " .. commit.hash .. "^!")
            vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
        end,
        on_select_range_commit = function(from, to)
            vim.notify("Git Diff: " .. from.hash .. "~1.." .. to.hash)
            vim.cmd(":DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
        end,
    },
    log_level = vim.log.levels.ERROR,
})
