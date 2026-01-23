return {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            workspace = {
                library = {
                    vim.env.VIMRUNTIME,
                },
            },
            diagnostics = {
                globals = { "vim", "Snacks" },
                disable = { "missing-fields", "undefined-field" },
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
