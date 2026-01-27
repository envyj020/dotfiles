vim.g.mapleader = " "
vim.g.maplocalleader = " "

local o = vim.opt
local undo_history_on = true

o.clipboard:append({ "unnamed", "unnamedplus" })
o.compatible = false
o.updatetime = 250
o.timeoutlen = 1000

--- Indentation
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.expandtab = true
o.autoindent = true

-- Search
o.wrapscan = true
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.incsearch = true

--- Wrapping
o.wrap = false

--- General
o.exrc = false
o.confirm = true
o.encoding = "UTF-8"
o.fileencoding = "UTF-8"
o.shortmess:append("Wc")
o.iskeyword:append("-")
o.termguicolors = true
o.backspace = { "indent", "eol", "start" }
o.list = false
o.listchars = { tab = "» ", trail = ".", nbsp = "␣" }
o.scrolloff = 10
o.number = true
o.breakindent = true
o.showcmd = true
o.swapfile = false
o.autoread = true
o.errorbells = false
o.fixeol = false
o.joinspaces = false
o.cursorline = true
o.backupcopy = "yes"
o.relativenumber = true
o.signcolumn = "yes"
o.hidden = true
o.splitright = true
o.splitbelow = true
o.modifiable = true
o.mouse = "a"
o.inccommand = "split"
o.foldmethod = "manual"
o.sessionoptions:remove("blank")
o.sessionoptions:append({ "tabpages", "globals" })
o.showtabline = 2
o.laststatus = 3

o.shada = "!,'150,<100,s20,h"
o.guicursor = "n:block-blink,v-i-c-ci:ver25-blink,r:hor20"
o.completeopt = "menu,menuone,noselect"
o.wildmode = "list:longest"
o.wildmenu = true
o.wildignore = { "*.o", "*.obj", "*~", "log/**", "tmp/**", "*.png", "*.jpg", "*.gif" }

-- Undo History
if undo_history_on and vim.fn.has("persistent_undo") == 1 then
    local undo_dir = vim.fs.joinpath(vim.fn.stdpath("state"), "undo")
    if vim.fn.isdirectory(undo_dir) == 0 then
        vim.fn.system({ "mkdir", "-p", undo_dir })
    end
    o.undodir = undo_dir
    o.undofile = true
end
