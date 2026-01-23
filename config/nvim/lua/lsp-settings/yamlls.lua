return require("schema-companion").setup_client({
    filetypes = {
        "yaml",
        "!yaml.ansible",
        "!yaml.docker-compose",
    },
    settings = {
        flags = {
            debounce_text_changes = 50,
        },
        redhat = { telemetry = { enabled = false } },
        yaml = {
            hover = true,
            completion = true,
            validate = true,
            format = { enable = false },
            schemaDownload = { enable = true },
            schemaStore = {
                enable = true,
                url = "https://www.schemastore.org/api/json/catalog.json",
            },
            schemas = {},
        },
    },
})
