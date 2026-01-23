-- https://envyj020.github.io/dotfiles/keybindings/neovim

local common = require("common")

local keymap_opts = common.keymap_opts
local command = common.command
local map = vim.keymap.set

-- Reload Neovim configuration
map("n", "<Leader>cr", common.nvim_config_reload, keymap_opts("Reload Neovim configuration"))

-- Session management
map("n", "<Leader>oc", common.nvim_session_manager("create"), keymap_opts("Creates a neovim session"))
map("n", "<Leader>od", common.nvim_session_manager("delete"), keymap_opts("Deletes a neovim session"))
map("n", "<Leader>ol", common.nvim_session_manager("load"), keymap_opts("Loads a neovim session"))

-- Scroll
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

-- Formatting
map("n", "ff", command("Format"), keymap_opts("Format code"))
map("n", "FF", command("FormatWrite"), keymap_opts("Format and write"))
map("n", "jq", command("JqxList"), keymap_opts("Jq/Yq quickfix"))
map("n", "jqq", command("JqxQuery"), keymap_opts("Jq/Yq query"))

-- NeoTree
map("n", "<leader>t", command("Neotree", "toggle", "reveal"), keymap_opts("Toggle NeoTree"))

-- Buffer Navigation
map("n", "<C-Down>", command("bprevious"), keymap_opts("Previous buffer"))
map("n", "<C-Up>", command("bnext"), keymap_opts("Next buffer"))
map("n", "<C-x>", require("mini.bufremove").delete, keymap_opts("Close buffer"))

-- Window Navigation
map("n", "<C-w><Left>", "<C-w>h", keymap_opts("Focus window left"))
map("n", "<C-w><Right>", "<C-w>l", keymap_opts("Focus window right"))
map("n", "<C-w><Up>", "<C-w>k", keymap_opts("Focus window above"))
map("n", "<C-w><Down>", "<C-w>j", keymap_opts("Focus window below"))
map("n", "<Leader>win", require("nvim-window").pick, keymap_opts("Window picker"))
map("n", "<Leader>wm", function()
    require("winmove").start_mode("move")
end, keymap_opts("Window interactive move"))

-- Window Management
map("n", "<C-w>x", "<C-w>c", keymap_opts("Close window"))
map("n", "<Leader>w-", "<C-w>n", keymap_opts("Horizontal split"))
map("n", "<Leader>w|", "<C-w>v", keymap_opts("Vertical split"))

map("n", "w<Left>", require("smart-splits").resize_left, keymap_opts("Resize window left"))
map("n", "w<Right>", require("smart-splits").resize_right, keymap_opts("Resize window right"))
map("n", "w<Up>", require("smart-splits").resize_up, keymap_opts("Resize window up"))
map("n", "w<Down>", require("smart-splits").resize_down, keymap_opts("Resize window down"))

map("n", "<Leader>fs", command("WindowsMaximize"), keymap_opts("Maximize window"))
map("n", "<C-w>=", command("WindowsEqualize"), keymap_opts("Equalize windows dimensions"))

-- Window Movement
map("n", "<Leader>w<Left>", "<C-w>H", keymap_opts("Move window left"))
map("n", "<Leader>w<Right>", "<C-w>L", keymap_opts("Move window right"))
map("n", "<Leader>w<Up>", "<C-w>K", keymap_opts("Move window up"))
map("n", "<Leader>w<Down", "<C-w>J", keymap_opts("Move window down"))

-- Tab Navigation
map("n", "<Tab><Right>", "gt", keymap_opts("Next tab"))
map("n", "<Tab><Left>", "gT", keymap_opts("Previous tab"))

-- Tab Management
map("n", "<Tab>n", command("tabnew"), keymap_opts("Create a new tab"))
map("n", "<Tab>q", command("tabclose"), keymap_opts("Close current tab"))
map("n", "<Tab>w", command("wa"), keymap_opts("Save *"))

-- Commentaries
map({ "n", "v" }, "<Leader>doc", command("Neogen"), keymap_opts("Create doc signature annotation"))
map({ "n", "v" }, "<Leader>cc", command("Commentary"), keymap_opts("Toggle comment"))
map({ "n", "v" }, "<Leader>cb", "{v}:Commentary<CR>", keymap_opts("Comment block"))

-- Rename
map({ "i", "n", "v" }, "<Leader>rn", require("renamer").rename, keymap_opts("Rename symbol"))

-- Markdown
map("n", "<Leader>mk", command("RenderMarkdown", "buf_toggle"), keymap_opts("Markdown inline render"))
map("n", "<Leader>mp", command("MarkdownPreview"), keymap_opts("Markdown preview"))
map("n", "<Leader>tocu", command("TOCList"), keymap_opts("Markdown ToC unordered list"))
map("n", "<Leader>toco", command("TOC"), keymap_opts("Markdown ToC ordered list"))
map("n", "<bs>", command("edit", "#<CR>"), keymap_opts("Previous markdown file", { silent = true }))

-- Git
map("n", "<Leader>g", command("Neogit"), keymap_opts("Open Neogit"))
map("n", "<Leader>gb", command("Gitsigns", "blame"), keymap_opts("Git blame"))
map("n", "<Leader>gbi", command("Gitsigns", "toggle_current_line_blame"), keymap_opts("Git inline blame"))
map("n", "<Leader>gl", function()
    require("gitgraph").draw({}, { all = true, max_count = 5000 })
end, keymap_opts("Git Log"))

-- Telescope
local telescope = require("telescope")
local builtin = require("telescope.builtin")

map("n", "<Leader>sh", builtin.help_tags, keymap_opts("Search help tags"))
map("n", "<Leader>sk", builtin.keymaps, keymap_opts("Search keymaps"))
map("n", "<Leader>sf", builtin.find_files, keymap_opts("Find files"))
map("n", "<Leader>sw", builtin.grep_string, keymap_opts("Grep string"))
map("n", "<Leader>sg", builtin.live_grep, keymap_opts("Live grep"))
map("n", "<Leader>so", builtin.oldfiles, keymap_opts("Recent files"))
map("n", "<Leader>sb", builtin.buffers, keymap_opts("Search buffers"))
map("n", "<Leader>gs", builtin.git_status, keymap_opts("Git status"))
map("n", "<Leader>gc", builtin.git_commits, keymap_opts("Git commits"))
map("n", "<Leader>yr", require("schema-companion.context").match, keymap_opts("YAML Schema match"))

-- YAML Schema picker
map("n", "<Leader>syc", telescope.extensions.schema_companion.select_schema, keymap_opts("Pick YAML schema"))
map(
    "n",
    "<Leader>sy",
    telescope.extensions.schema_companion.select_from_matching_schemas,
    keymap_opts("Choose matching buffer YAML schemas")
)
map(
    "n",
    "<Leader>kv",
    require("schema-companion.matchers.kubernetes").change_version,
    keymap_opts("Change Kubernetes API version YAML schema")
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

-- DAP Integrations
map("n", "<Leader>dgt", require("dap-go").debug_test, keymap_opts("Debug GO test under cursor"))
map("n", "<Leader>dpt", require("dap-python").test_method, keymap_opts("Debug Python test under cursor"))
map("n", "<Leader>dpc", require("dap-python").test_class, keymap_opts("Debug Python class"))

-- Terminal
map("n", "<Leader>;", command("ToggleTerm"), keymap_opts("Toggle terminal"))

-- Miscellaneous
map("n", "<Leader>tw", function()
    _G.Snacks.toggle.dim():toggle()
end, keymap_opts("Toggle focus mode"))

map("n", "<Leader>url", command("UrlView"), keymap_opts("Find URLs"))

-- Shortcuts
map("t", "<Esc>", "<C-\\><C-n>", keymap_opts("Exit terminal mode"))
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

--- Cloak
map("n", "<Leader>h", command("CloakToggle"), keymap_opts("Toggle sensitive data"))

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
end, keymap_opts("VSnip expand", { expr = true }))

-- Expand or Jump
map({ "i", "s" }, "<C-l>", function()
    if vim.fn["vsnip#available"](1) == 1 then
        return "<Plug>(vsnip-expand-or-jump)"
    else
        return "<C-l>"
    end
end, keymap_opts("VSnip expand or jump", { expr = true }))

-- Jump forward
map({ "i", "s" }, "<Tab>", function()
    if vim.fn["vsnip#jumpable"](1) == 1 then
        return "<Plug>(vsnip-jump-next)"
    else
        return "<Tab>"
    end
end, keymap_opts("VSnip jump next", { expr = true }))

-- Jump backward
map({ "i", "s" }, "<S-Tab>", function()
    if vim.fn["vsnip#jumpable"](-1) == 1 then
        return "<Plug>(vsnip-jump-prev)"
    else
        return "<S-Tab>"
    end
end, keymap_opts("VSnip jump previous", { expr = true }))
