require("go").setup({
    diagnostic = false,
    fillstruct = "gopls",
    goimports = "gopls",
    gofmt = "gopls",
    lsp_document_formatting = true,
    lsp_inlay_hints = {
        enable = false,
    },
})

require("uv").setup({
    picker_integration = true,
})
