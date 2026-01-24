local common = require("common")

local keymap_opts = common.keymap_opts
local command = common.command
local map = vim.keymap.set

map(
    "n",
    "<Leader>mk",
    command("RenderMarkdown", "buf_toggle"),
    keymap_opts("Markdown inline render", { buffer = true })
)
map("n", "<Leader>mp", command("MarkdownPreview"), keymap_opts("Markdown preview", { buffer = true }))
map("n", "<Leader>tocu", command("TOCList"), keymap_opts("Markdown ToC unordered list", { buffer = true }))
map("n", "<Leader>toco", command("TOC"), keymap_opts("Markdown ToC ordered list", { buffer = true }))
map("n", "<bs>", command("edit", "#<CR>"), keymap_opts("Previous markdown file", { buffer = true, silent = true }))
