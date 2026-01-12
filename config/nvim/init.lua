local NVIM_PLUG_URL = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
local NVIM_PLUG_DESTINATION = vim.fs.joinpath(vim.fn.stdpath("data"), "site/autoload/plug.vim")
local NVIM_PLUG_INSTALLED = vim.loop.fs_access(NVIM_PLUG_DESTINATION, "R")

if not NVIM_PLUG_INSTALLED then
    vim.fn.system({
        "curl",
        "-fLo",
        NVIM_PLUG_DESTINATION,
        "--create-dirs",
        NVIM_PLUG_URL,
    })
    vim.cmd("source " .. NVIM_PLUG_DESTINATION)
    vim.cmd("autocmd VimEnter * PlugInstall --sync | source $MYVIMRC")
end

require("core.options")
require("core.autocmd")
require("core.filetypes")
require("plugins")

if NVIM_PLUG_INSTALLED then
    require("core.keymaps")
    require("core.settings")
    require("core.highlights")

    -- Color Scheme
    local NVIM_COLORSCHEME = os.getenv("NVIM_COLORSCHEME") or "catppuccin-mocha"
    vim.cmd("colorscheme " .. NVIM_COLORSCHEME)

    --- Import Plugins config
    require("plugins.avante")
    require("plugins.cmp")
    require("plugins.dap")
    require("plugins.mason")
    require("plugins.linters")
    require("plugins.formatter")
    require("plugins.dev")
    require("plugins.lsp")
    require("plugins.mini")
    require("plugins.misc")
    require("plugins.neogen")
    require("plugins.neogit")
    require("plugins.neotree")
    require("plugins.noice")
    require("plugins.snacks")
    require("plugins.statusline")
    require("plugins.tabby")
    require("plugins.telescope")
    require("plugins.terminal")
    require("plugins.treesitter")
    require("plugins.windows")
    require("plugins.diagnostic")
end
