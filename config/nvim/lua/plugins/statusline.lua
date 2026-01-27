local lualine = require("lualine")
local catppuccin = require("extensions.palette").extended(vim.g.catppuccin_theme)

local colors = {
    bg = catppuccin.base,
    fg = catppuccin.peach,
    blue = catppuccin.lavender,
    yellow = catppuccin.yellow,
    cyan = catppuccin.mauve,
    green = catppuccin.green,
    orange = catppuccin.peach,
    red = catppuccin.red,
    darkblue = catppuccin.darkblue,
    violet = catppuccin.violet,
    magenta = catppuccin.magenta,
}

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

local config = {
    options = {
        icons_enabled = true,
        component_separators = "",
        section_separators = "",
        theme = {
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
            refresh_time = 16,
            events = {
                "WinEnter",
                "BufEnter",
                "BufWritePost",
                "SessionLoadPost",
                "FileChangedShellPost",
                "VimResized",
                "Filetype",
                "CursorMoved",
                "CursorMovedI",
                "ModeChanged",
            },
        },
    },
    sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },
}

local function insert_left(component)
    table.insert(config.sections.lualine_c, component)
end

local function insert_right(component)
    table.insert(config.sections.lualine_x, component)
end

-- Left section
insert_left({
    function()
        return "▊"
    end,
    color = { fg = colors.oragen },
    padding = { left = 0, right = 1 },
})

insert_left({
    "mode",
    color = function()
        local mode_color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            [""] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [""] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ["r?"] = colors.cyan,
            ["!"] = colors.red,
            t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()], gui = "bold" }
    end,
    padding = { right = 1 },
})

insert_left({
    "filesize",
    cond = conditions.buffer_not_empty,
})

insert_left({
    "filetype",
    fmt = string.upper,
    color = { fg = colors.green, gui = "bold" },
})

insert_left({
    "filename",
    cond = conditions.buffer_not_empty,
    color = { fg = colors.yellow, gui = "bold" },
})

insert_left({ "location" })

insert_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

insert_left({
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " " },
    diagnostics_color = {
        error = { fg = colors.red },
        warn = { fg = colors.yellow },
        info = { fg = colors.cyan },
    },
})

insert_left({
    function()
        local msg = "None"
        local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
        local clients = vim.lsp.get_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return string.upper(client.name)
            end
        end
        return msg
    end,
    icon = "󰠳 LSP:",
    cond = conditions.buffer_not_empty,
    color = { fg = colors.cyan, gui = "bold" },
})

-- Right section
insert_right({
    function()
        local formatters = require("formatter.config").formatters_for_filetype(vim.bo.filetype)
        local formatter_names = {}
        for _, formatter_func in ipairs(formatters) do
            if type(formatter_func) == "function" then
                local formatter = formatter_func()
                if formatter and formatter.exe and formatter.exe ~= "sed" then
                    table.insert(formatter_names, formatter.exe)
                end
            end
        end
        return #formatter_names == 0 and "" or #formatter_names
    end,
    icon = " F:",
    cond = conditions.buffer_not_empty,
    color = { fg = colors.orange, gui = "bold" },
})

insert_right({
    function()
        local linters = require("lint").get_running()
        if #linters == 0 then
            return "󰄳"
        end
        return "󱉶 " .. table.concat(linters, ", ")
    end,
    icon = "󰃣 L:",
    cond = conditions.buffer_not_empty,
    color = { fg = colors.orange, gui = "bold" },
})

insert_right({
    "o:encoding",
    fmt = string.upper,
    cond = conditions.hide_in_width,
    color = { fg = colors.green, gui = "bold" },
})

insert_right({
    "fileformat",
    fmt = string.upper,
    icon = "",
    color = { fg = colors.green, gui = "bold" },
})

insert_right({
    "branch",
    icon = "",
    color = { fg = colors.violet, gui = "bold" },
})

insert_right({
    "diff",
    symbols = { added = " ", modified = "󰝤 ", removed = " " },
    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
    },
    cond = conditions.hide_in_width,
})

insert_right({
    function()
        return "▊"
    end,
    color = { fg = colors.orange },
    padding = { left = 1 },
})

lualine.setup(config)
