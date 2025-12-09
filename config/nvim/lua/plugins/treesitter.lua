require("nvim-treesitter.configs").setup({
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    modules = {},
    ensure_installed = {
        "http",
        "json",
        "toml",
        "yaml",
        "ini",
        "regex",
        "diff",
        "sql",
        "csv",
        "vim",
        "html",
        "css",
        "scss",
        "nix",
        "lua",
        "bash",
        "python",
        "php",
        "tsx",
        "typst",
        "vue",
        "rust",
        "javascript",
        "typescript",
        "groovy",
        "ruby",
        "scala",
        "java",
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "kcl",
        "terraform",
        "helm",
        "dockerfile",
        "gitignore",
        "gitcommit",
        "markdown",
        "markdown_inline",
        "requirements",
        "properties",
        "comment",
        "proto",
        "norg",
    },
    refactor = {
        highlight_current_scope = { enable = false },
        highlight_definitions = {
            enable = true,
            clear_on_cursor_move = true,
        },
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "rn",
            },
        },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition = "gnd",
                list_definitions = "gnD",
                list_definitions_toc = "gO",
                goto_next_usage = "<a-*>",
                goto_previous_usage = "<a-#>",
            },
        },
    },
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",    -- maps in normal mode to init the node/scope selection
            node_incremental = "grn",  -- increment to the upper named parent
            scope_incremental = "grc", -- increment to the upper scope (as defined in locals.scm)
            node_decremental = "grm",  -- decrement to the previous node
        },
    },
    textobjects = {
        enable = true,
        lsp_interop = {
            enable = true,
            peek_definition_code = {
                ["<leader>df"] = "@function.outer",
                ["<leader>dF"] = "@class.outer",
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["nm"] = "@function.outer",
                ["nc"] = "@class.outer",
                ["np"] = "@parameter.inner",
                ["nP"] = "@parameter.outer",
            },
            goto_next_end = {
                ["nM"] = "@function.outer",
                ["nC"] = "@class.outer",
            },
            goto_previous_start = {
                ["pm"] = "@function.outer",
                ["pc"] = "@class.outer",
                ["pp"] = "@parameter.inner",
                ["pP"] = "@parameter.outer",
            },
            goto_previous_end = {
                ["pM"] = "@function.outer",
                ["pC"] = "@class.outer",
            },
        },
        select = {
            enable = true,
            keymaps = {
                ["of"] = "@function.outer",
                ["if"] = "@function.inner",
                ["oc"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["op"] = "@parameter.outer",
                ["ip"] = "@parameter.inner",
                ["ov"] = "@assignment.outer",
                ["iv"] = "@assignment.inner",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
    },
})
