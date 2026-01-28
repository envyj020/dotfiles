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
