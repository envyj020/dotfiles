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
    vim.cmd("autocmd VimEnter * PlugInstall --sync | source $MYVIMRC")
end

require("core.options")
require("core.autocmd")
require("core.filetypes")

if NVIM_PLUG_INSTALLED then
    require("plugins")
    require("core.keymaps")
    require("core.settings")
    require("core.highlights")
end
