-- https://envyj020.github.io/dotfiles/keybindings/neovim

local common = require("common")

local keymap_opts = common.keymap_opts
local command = common.command
local map = vim.keymap.set

-- Reload Neovim configuration
map("n", "<Leader>cr", common.nvim_config_reload, keymap_opts("Reload Neovim configuration"))

-- Session management
map("n", "<Leader>oc", common.nvim_session_manager("create"), keymap_opts("Session: creates a neovim session"))
map("n", "<Leader>od", common.nvim_session_manager("delete"), keymap_opts("Session: deletes a neovim session"))
map("n", "<Leader>ol", common.nvim_session_manager("load"), keymap_opts("Session: loads a neovim session"))

-- Formatting
map("n", "ff", command("Format"), keymap_opts("Format code"))
map("n", "FF", command("FormatWrite"), keymap_opts("Format and write"))

-- File Manager
map("n", "<Leader>t", command("Neotree", "toggle", "reveal"), keymap_opts("Toggle NeoTree"))

-- Flash
map({ "n", "x", "o" }, "s", function()
    require("flash").jump()
end, keymap_opts("Flash"))
map({ "n", "x", "o" }, "S", function()
    require("flash").treesitter()
end, keymap_opts("Flash: treesitter"))
map({ "x", "o" }, "r", function()
    require("flash").treesitter_search()
end, keymap_opts("Flash: treesitter search"))

-- Treesitter
local treesitter_select = require("nvim-treesitter-textobjects.select").select_textobject
local treesitter_swap = require("nvim-treesitter-textobjects.swap")
local treesitter_move = require("nvim-treesitter-textobjects.move")

--- Context
map("n", "<Leader>c", function()
    require("treesitter-context").go_to_context(vim.v.count1)
end, keymap_opts("Treesitter: jump to context", { silent = true }))

--- Select
--- @Function
map({ "x", "o" }, "of", function()
    treesitter_select("@function.outer", "textobjects")
end, keymap_opts("Treesitter: @function.outer:s"))
map({ "x", "o" }, "if", function()
    treesitter_select("@function.inner", "textobjects")
end, keymap_opts("Treesitter: @function.inner:s"))

--- @Class
map({ "x", "o" }, "oc", function()
    treesitter_select("@class.outer", "textobjects")
end, keymap_opts("Treesitter: @class.outer:s"))
map({ "x", "o" }, "ic", function()
    treesitter_select("@class.inner", "textobjects")
end, keymap_opts("Treesitter: @class.inner:s"))

--- @Parameter
map({ "x", "o" }, "op", function()
    treesitter_select("@parameter.outer", "textobjects")
end, keymap_opts("Treesitter: @parameter.outer:s"))
map({ "x", "o" }, "ip", function()
    treesitter_select("@parameter.inner", "textobjects")
end, keymap_opts("Treesitter: @parameter.inner:s"))

--- @Variable
map({ "x", "o" }, "ov", function()
    treesitter_select("@assignment.outer", "textobjects")
end, keymap_opts("Treesitter: @assignment.outer:s"))
map({ "x", "o" }, "iv", function()
    treesitter_select("@assignment.inner", "textobjects")
end, keymap_opts("Treesitter: @assignment.inner:s"))

--- Swap
map("n", "<Leader>a", function()
    treesitter_swap.swap_next("@parameter.inner")
end, keymap_opts("Treesitter: @swap.next"))
map("n", "<Leader>A", function()
    treesitter_swap.swap_previous("@parameter.outer")
end, keymap_opts("Treesitter: @swap.previous"))

--- Move
--- @Parameter
map({ "n", "x", "o" }, "np", function()
    treesitter_move.goto_next_start("@parameter.outer", "textobjects")
end, keymap_opts("Treesitter: @parameter.outer:m next start"))
map({ "n", "x", "o" }, "nP", function()
    treesitter_move.goto_next_end("@parameter.outer", "textobjects")
end, keymap_opts("Treesitter: @parameter.outer:m next end"))

map({ "n", "x", "o" }, "pp", function()
    treesitter_move.goto_previous_start("@parameter.outer", "textobjects")
end, keymap_opts("Treesitter: @parameter.outer:m previous start"))
map({ "n", "x", "o" }, "pP", function()
    treesitter_move.goto_previous_end("@parameter.outer", "textobjects")
end, keymap_opts("Treesitter: @parameter.outer:m previous end"))

--- @Function
map({ "n", "x", "o" }, "nf", function()
    treesitter_move.goto_next_start("@function.outer", "textobjects")
end, keymap_opts("Treesitter: @function.outer:m next start"))
map({ "n", "x", "o" }, "nF", function()
    treesitter_move.goto_next_end("@function.outer", "textobjects")
end, keymap_opts("Treesitter: @function.outer:m next end"))

map({ "n", "x", "o" }, "pf", function()
    treesitter_move.goto_previous_start("@function.outer", "textobjects")
end, keymap_opts("Treesitter: @function.outer:m previous start"))
map({ "n", "x", "o" }, "pF", function()
    treesitter_move.goto_previous_end("@function.outer", "textobjects")
end, keymap_opts("Treesitter: @function.outer:m previous end"))

--- @Class
map({ "n", "x", "o" }, "nc", function()
    treesitter_move.goto_next_start("@class.outer", "textobjects")
end, keymap_opts("Treesitter: @class.outer:m next start"))
map({ "n", "x", "o" }, "nC", function()
    treesitter_move.goto_next_end("@class.outer", "textobjects")
end, keymap_opts("Treesitter: @class.outer:m next end"))

map({ "n", "x", "o" }, "pc", function()
    treesitter_move.goto_previous_start("@class.outer", "textobjects")
end, keymap_opts("Treesitter: @class.outer:m previous start"))
map({ "n", "x", "o" }, "pC", function()
    treesitter_move.goto_previous_end("@class.outer", "textobjects")
end, keymap_opts("Treesitter: @class.outer:m previous end"))

-- Buffer Navigation
map("n", "<C-Down>", command("bprevious"), keymap_opts("Buffer: previous buffer"))
map("n", "<C-Up>", command("bnext"), keymap_opts("Buffer: next buffer"))
map("n", "<C-x>", require("mini.bufremove").delete, keymap_opts("Buffer: close buffer"))

-- Window Navigation
map("n", "<C-w><Left>", "<C-w>h", keymap_opts("Window: focus window left"))
map("n", "<C-w><Right>", "<C-w>l", keymap_opts("Window: focus window right"))
map("n", "<C-w><Up>", "<C-w>k", keymap_opts("Window: focus window above"))
map("n", "<C-w><Down>", "<C-w>j", keymap_opts("Window: focus window below"))
map("n", "<Leader>win", require("nvim-window").pick, keymap_opts("Window: picker"))
map("n", "<Leader>wm", function()
    require("winmove").start_mode("move")
end, keymap_opts("Window: interactive move"))

-- Window Management
map("n", "<C-w>x", "<C-w>c", keymap_opts("Window: close window"))
map("n", "<Leader>w-", "<C-w>n", keymap_opts("Window: horizontal split"))
map("n", "<Leader>w|", "<C-w>v", keymap_opts("Window: vertical split"))

map("n", "w<Left>", require("smart-splits").resize_left, keymap_opts("Window: resize window left"))
map("n", "w<Right>", require("smart-splits").resize_right, keymap_opts("Window: resize window right"))
map("n", "w<Up>", require("smart-splits").resize_up, keymap_opts("Window: resize window up"))
map("n", "w<Down>", require("smart-splits").resize_down, keymap_opts("Window: resize window down"))

map("n", "<Leader>fs", command("WindowsMaximize"), keymap_opts("Window: maximize window"))
map("n", "<C-w>=", command("WindowsEqualize"), keymap_opts("Window: equalize windows dimensions"))

-- Window Movement
map("n", "<Leader>w<Left>", "<C-w>H", keymap_opts("Window: move window left"))
map("n", "<Leader>w<Right>", "<C-w>L", keymap_opts("Window: move window right"))
map("n", "<Leader>w<Up>", "<C-w>K", keymap_opts("Window: move window up"))
map("n", "<Leader>w<Down", "<C-w>J", keymap_opts("Window: move window down"))

-- Tab Navigation
map("n", "<Tab><Right>", "gt", keymap_opts("Tab: next tab"))
map("n", "<Tab><Left>", "gT", keymap_opts("Tab: previous tab"))

-- Tab Management
map("n", "<Tab>n", command("tabnew"), keymap_opts("Tab: create a new tab"))
map("n", "<Tab>x", command("tabclose"), keymap_opts("Tab: close current tab"))
map("n", "<Tab>r", common.rename_tab, keymap_opts("Tab: rename current tab"))
map("n", "<Tab>w", command("wa"), keymap_opts("Tab: save *"))

-- Commentaries
map({ "n", "v" }, "<Leader>doc", command("Neogen"), keymap_opts("Docs: create doc signature annotation"))
map({ "n", "v" }, "<Leader>cc", command("Commentary"), keymap_opts("Docs: toggle inline comment"))
map({ "n", "v" }, "<Leader>cb", "{v}:Commentary<CR>", keymap_opts("Docs: toggle comment block"))

-- Rename
map({ "n", "v" }, "<Leader>rn", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
end, keymap_opts("Refactor: rename symbol", { expr = true }))

-- Git
map("n", "<Leader>g", command("Neogit"), keymap_opts("Git: open Neogit"))
map("n", "<Leader>gb", command("Gitsigns", "blame"), keymap_opts("Git: blame"))
map("n", "<Leader>gbi", command("Gitsigns", "toggle_current_line_blame"), keymap_opts("Git: inline blame"))
map("n", "<Leader>gl", function()
    require("gitgraph").draw({}, { all = true, max_count = 5000 })
end, keymap_opts("Git: Log"))

-- Telescope
local telescope = require("telescope")
local builtin = require("telescope.builtin")

map("n", "<Leader>sh", builtin.help_tags, keymap_opts("Search: help tags"))
map("n", "<Leader>sk", builtin.keymaps, keymap_opts("Search: keymaps"))
map("n", "<Leader>sf", builtin.find_files, keymap_opts("Search: find files"))
map("n", "<Leader>sw", builtin.grep_string, keymap_opts("Search: grep string"))
map("n", "<Leader>sg", builtin.live_grep, keymap_opts("Search: live grep"))
map("n", "<Leader>so", builtin.oldfiles, keymap_opts("Search: recent files"))
map("n", "<Leader>sb", builtin.buffers, keymap_opts("Search: buffers"))
map("n", "<Leader>gs", builtin.git_status, keymap_opts("Search: git status"))
map("n", "<Leader>gc", builtin.git_commits, keymap_opts("Search: git commits"))
map("n", "<Leader>yr", require("schema-companion.context").match, keymap_opts("YAML: schema match"))

-- Marks
map("n", "<Leader>sm", command("MarksListBuf"), keymap_opts("Find Marks"))

-- YAML Schema picker
map("n", "<Leader>syc", telescope.extensions.schema_companion.select_schema, keymap_opts("YAML: schema picker"))
map(
    "n",
    "<Leader>sy",
    telescope.extensions.schema_companion.select_from_matching_schemas,
    keymap_opts("YAML: choose matching buffer schemas")
)
map(
    "n",
    "<Leader>kv",
    require("schema-companion.matchers.kubernetes").change_version,
    keymap_opts("YAML: change Kubernetes API version schema")
)

-- DAP
map("n", "<Leader>dB", function()
    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, keymap_opts("DAP: sets a breakpoint with a given condition"))
map("n", "<Leader>dn", command("DapNew"), keymap_opts("DAP: starts a session"))
map("n", "<Leader>dc", command("DapContinue"), keymap_opts("DAP: starts or continues a session"))
map("n", "<Leader>db", command("DapToggleBreakpoint"), keymap_opts("DAP: sets or removes a breakpoint"))
map("n", "<Leader>dso", command("DapStepOver"), keymap_opts("DAP: executes the current LoC skipping func"))
map("n", "<Leader>dsi", command("DapStepInto"), keymap_opts("DAP: executes the current LoC delving func"))
map("n", "<Leader>do", command("DapStepOut"), keymap_opts("DAP: steps out from an stepped in func"))
map("n", "<Leader>dp", command("DapPause"), keymap_opts("DAP: halts the execution"))
map("n", "<Leader>ds", command("DapStop"), keymap_opts("DAP: terminates the session"))
map("n", "<Leader>dex", command("DapToggleRepl"), keymap_opts("DAP: executes an evaluates an expression"))
map("n", "nb", require("goto-breakpoints").next, keymap_opts("DAP: next breakpoint"))
map("n", "pb", require("goto-breakpoints").prev, keymap_opts("DAP: previous breakpoint"))
map("n", "sb", require("goto-breakpoints").stopped, keymap_opts("DAP: current stopped breakpoint"))

-- DAP Integrations - NeoTest
map("n", "<Leader>tnd", function()
    require("neotest").run.run({ suite = false, strategy = "dap" })
end, keymap_opts("Debug: run nearest test with DAP integration"))

map("n", "<Leader>tfd", function()
    require("neotest").run.run({ vim.fn.expand("%"), suite = false, strategy = "dap" })
end, keymap_opts("Debug: run current test file with DAP integration"))

map("n", "<Leader>tn", function()
    require("neotest").run.run({ suite = false })
end, keymap_opts("Test: run nearest test"))

map("n", "<Leader>tf", function()
    require("neotest").run.run({ vim.fn.expand("%"), suite = false })
end, keymap_opts("Test: run current test file"))

map("n", "<leader>td", function()
    require("neotest").run.run({ vim.fn.getcwd(), suite = false })
end, keymap_opts("Test: run current dir tests"))

map("n", "<Leader>ts", function()
    require("neotest").summary.toggle()
end, keymap_opts("Debug: open summary"))

map("n", "<Leader>tt", function()
    require("neotest").run.stop()
end, keymap_opts("Test: stop test execution"))

vim.keymap.set("n", "<Leader>to", function()
    require("neotest").output.open({ enter = true, auto_close = true })
end, { desc = "Debug: open test output" })

vim.keymap.set("n", "<Leader>top", function()
    require("neotest").output_panel.toggle()
end, { desc = "Debug: open test output panel" })

vim.keymap.set("n", "<Leader>tw", function()
    require("neotest").watch.toggle(vim.fn.expand("%"))
end, { desc = "Test: run test on file changes" })

-- Terminal
map("n", "<Leader>;", command("ToggleTerm"), keymap_opts("Terminal: toggle"))
map("t", "<Esc>", "<C-\\><C-n>", keymap_opts("Terminal: exit"))

-- Miscellaneous
map("n", "jq", command("JqxList"), keymap_opts("Jq/Yq quickfix"))
map("n", "jqq", command("JqxQuery"), keymap_opts("Jq/Yq query"))

map("n", "<Leader>h", command("CloakToggle"), keymap_opts("Toggle sensitive data"))

map("n", "<Leader>z", function()
    Snacks.toggle.dim():toggle()
end, keymap_opts("Toggle focus mode"))

map("n", "<C-a>", function()
    require("dial.map").manipulate("increment", "normal")
end, keymap_opts("Increment version"))

map("n", "<C-x>", function()
    require("dial.map").manipulate("decrement", "normal")
end, keymap_opts("Decrement version"))

map({ "n", "v", "x" }, "<S-Up>", function()
    require("neoscroll").ctrl_u({
        duration = 150,
    })
end, keymap_opts("Scroll up"))
map({ "n", "v", "x" }, "<S-Down>", function()
    require("neoscroll").ctrl_d({
        duration = 150,
    })
end, keymap_opts("Scroll down"))

-- Mutations
map("i", "<Del>", "<C-\\><C-o>db", keymap_opts("Delete previous word"))
map("n", "<Del>", "db", keymap_opts("Delete previous word"))
map("n", "<Leader>qq", 'ysiw"', keymap_opts("Surround word with double quotes", { remap = true }))

map("n", "<Leader>q", function()
    local position = vim.fn.getpos(".")
    local line = vim.api.nvim_get_current_line()
    local column = position[3]

    local before_cursor = line:sub(1, column):reverse()
    local d_position = before_cursor:find('"')
    local s_position = before_cursor:find("'")

    if d_position and (not s_position or d_position < s_position) then
        vim.cmd([[normal cs"']])
    else
        vim.cmd([[normal cs'"]])
    end

    vim.fn.setpos(".", position)
end, keymap_opts("Toggle surrounding quotes"))

--- Database
map("n", "<Leader>ddb", function()
    vim.cmd("tabnew")
    vim.cmd("DBUI")
end, keymap_opts("Open Database UI"))

-- Undo break points
map("i", ",", ",<c-g>u", keymap_opts("Undo break point"))
map("i", ".", ".<c-g>u", keymap_opts("Undo break point"))
map("i", "!", "!<c-g>u", keymap_opts("Undo break point"))
map("i", "?", "?<c-g>u", keymap_opts("Undo break point"))
map("i", ":", ":<c-g>u", keymap_opts("Undo break point"))
map("i", ";", ";<c-g>u", keymap_opts("Undo break point"))

-- Fold
map("i", "¨", "<C-O>za", keymap_opts("Toggle fold"))
map("n", "¨", "za", keymap_opts("Toggle fold"))
map("o", "¨", "<C-C>za", keymap_opts("Toggle fold"))
map("v", "¨", "zf", keymap_opts("Create fold"))

-- Jumplist mutations
map("n", "k", function()
    return (vim.v.count > 5 and "m'" .. vim.v.count or "") .. "k"
end, keymap_opts("Move up with jumplist", { expr = true }))

map("n", "j", function()
    return (vim.v.count > 5 and "m'" .. vim.v.count or "") .. "j"
end, keymap_opts("Move down with jumplist", { expr = true }))

-- Vsnip Navigation

-- Expand
map({ "i", "s" }, "<C-j>", function()
    if vim.fn["vsnip#expandable"]() == 1 then
        return "<Plug>(vsnip-expand)"
    else
        return "<C-j>"
    end
end, keymap_opts("Snippet: expand", { expr = true }))

-- Expand or Jump
map({ "i", "s" }, "<C-l>", function()
    if vim.fn["vsnip#available"](1) == 1 then
        return "<Plug>(vsnip-expand-or-jump)"
    else
        return "<C-l>"
    end
end, keymap_opts("Snippet: expand or jump", { expr = true }))

-- Jump forward
map({ "i", "s" }, "<Tab>", function()
    if vim.fn["vsnip#jumpable"](1) == 1 then
        return "<Plug>(vsnip-jump-next)"
    else
        return "<Tab>"
    end
end, keymap_opts("Snippet: jump next", { expr = true }))

-- Jump backward
map({ "i", "s" }, "<S-Tab>", function()
    if vim.fn["vsnip#jumpable"](-1) == 1 then
        return "<Plug>(vsnip-jump-prev)"
    else
        return "<S-Tab>"
    end
end, keymap_opts("Snippet: jump previous", { expr = true }))
