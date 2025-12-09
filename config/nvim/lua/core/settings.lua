vim.g.editorconfig = true

-- In case I come back to NerdTree
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeWinSize = 60
vim.g.NERDTreeFileExtensionHighlightFullName = 1
vim.g.NERDTreeExactMatchHighlightFullName = 1
vim.g.NERDTreePatternMatchHighlightFullName = 1
vim.g.NERDTreeHighlightFolders = 1
vim.g.NERDTreeHighlightFoldersFullName = 1

vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 1
vim.g.mkdp_command_for_global = 0
vim.g.mkdp_markdown_css = vim.fn.expand("$HOME/markdown.css")
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_follow_anchor = 1

vim.g.AutoPairsShortcutToggle = ""
vim.g.AutoPairsShortcutBackInsert = "<M-0>"

vim.g.diagnostic_enable_virtual_text = 1
vim.g.diagnostic_virtual_text_prefix = " "

vim.g.closetag_filetypes = "html,xhtml,phtml"
vim.g.closetag_xhtml_filetypes = "xhtml,jsx"
vim.g.closetag_shortcut = ">"

vim.g.neovim_session_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "obsession")
