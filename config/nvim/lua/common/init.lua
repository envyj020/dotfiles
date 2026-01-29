local M = {}

M.headless = #vim.api.nvim_list_uis() == 0

--- Concatenates a variadic number of tables
---@param ... table[] Variadic number of tables to concatenate
---@return table extended A new table containing all the elements from the input tables
function M.concat_tables(...)
    local extended = {}
    for _, tbl in ipairs({ ... }) do
        assert(type(tbl) == "table", ("Invalid argument type, expected a table but got %s"):format(type(tbl)))
        vim.list_extend(extended, tbl)
    end
    return extended
end

--- Reloads Neovim configuration by wiping out user cached modules.
function M.nvim_config_reload()
    local mod_patterns = {}
    local modules = vim.fs.dir(vim.fs.joinpath(vim.fn.stdpath("config"), "lua"), {
        depth = 1,
    })

    for name, type in modules do
        if type == "directory" then
            table.insert(mod_patterns, string.format("^%s", name))
        end
    end

    for name, _ in pairs(package.loaded) do
        for _, pattern in ipairs(mod_patterns) do
            if name:find(pattern) then
                package.loaded[name] = nil
                break
            end
        end
    end
    vim.cmd("source " .. os.getenv("MYVIMRC"))
    vim.notify("Config Reloaded Successfully!", vim.log.levels.INFO, { title = "Neovim" })
end

--- Prepares the keymap options for a given mapping
---@param desc string Command description
---@param extra_opts table|nil Extra options
---@return table
function M.keymap_opts(desc, extra_opts)
    local opts = { desc = desc }
    extra_opts = extra_opts or {}
    for k, v in pairs(extra_opts) do
        opts[k] = v
    end
    return opts
end

--- Prepares a keymap command
---@param cmd string Main command
---@vararg ... string|nil Optional subcommands
---@return string Formatted command to use in vim.keymap.set
function M.command(cmd, ...)
    local args = table.concat({ ... }, " ")
    return (":%s%s<CR>"):format(cmd, args ~= "" and " " .. args or "")
end

--- Manages a neovim session, requires tpope/vim-obsession
---@param action string create|delete|load
---@return function
function M.nvim_session_manager(action)
    local valid_actions = { create = true, load = true, delete = true }

    local function notify_session_action(message, level)
        vim.notify(message, level or vim.log.levels.INFO, { title = "Neovim session" })
    end

    if not valid_actions[action] then
        notify_session_action(
            string.format(
                "Invalid action '%s'. Valid actions: %s",
                action,
                table.concat(vim.tbl_keys(valid_actions), ", ")
            ),
            vim.log.levels.ERROR
        )
    end

    return function()
        local workspace = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        local session_name = workspace
        local branch = nil

        if vim.fn.exists("*FugitiveHead") == 1 then
            branch = vim.fn.FugitiveHead()
        else
            local result = vim.fn.system("git branch --show-current 2>/dev/null")
            if vim.v.shell_error == 0 then
                branch = vim.trim(result)
            end
        end

        if branch and branch ~= "" then
            session_name = string.format("%s-%s", workspace, branch)
        end

        local session_dir = vim.g.neovim_session_dir or vim.fs.joinpath(vim.fn.stdpath("data"), "obsession")
        local session_path = vim.fs.joinpath(session_dir, session_name .. ".session.vim")

        local ok, err = pcall(vim.fn.mkdir, session_dir, "p")
        if not ok then
            notify_session_action(string.format("Failed to create session directory: %s", err), vim.log.levels.ERROR)
            return
        end

        local session_exists = vim.fn.filereadable(session_path) == 1

        local actions = {
            delete = function()
                if session_exists then
                    vim.cmd("Obsession!")
                else
                    notify_session_action("No session found for " .. workspace, vim.log.levels.WARN)
                end
            end,

            create = function()
                vim.cmd(string.format("Obsession %s", vim.fn.fnameescape(session_path)))
            end,

            load = function()
                if session_exists then
                    vim.cmd(string.format("source %s", vim.fn.fnameescape(session_path)))
                    notify_session_action("Load session from " .. session_path)
                else
                    notify_session_action("No session found for " .. workspace, vim.log.levels.WARN)
                end
            end,
        }

        actions[action]()
    end
end

--- Renames a Tabby tab interactively, requires nanozuki/tabby.nvim
function M.rename_tab()
    local bufnr = vim.api.nvim_get_current_buf()
    local bufn = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t")
    local win_id = vim.api.nvim_get_current_win()
    local tab_id = vim.api.nvim_win_get_tabpage(win_id)
    local tab_name = require("tabby.feature.tab_name").get(tab_id)

    vim.ui.input({
        prompt = "Enter tab name:",
        default = tab_name or "",
        completion = "dir",
    }, function(name)
        if not name or name == "" or name == bufn or name == tab_name then
            return
        end
        name = (name:gsub("%s+", "")):sub(0, 15)
        require("tabby").tab_rename(name)
    end)
end

return M
