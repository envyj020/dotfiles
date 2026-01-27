local catppuccin = require("extensions.palette").extended(vim.g.catppuccin_theme)

local theme = {
    fill = "TabLineFill",
    head = "TabLine",
    tab = "TabLine",
    win = "TabLine",
    tail = "TabLine",
    current_tab = "TabLineSel",
}

require("tabby").setup({
    preset = "active_wins_at_tail",
    line = function(line)
        return {
            {
                { "  ", hl = { fg = catppuccin.green, bg = catppuccin.base } },
                line.sep("", theme.head, theme.fill),
            },
            line.tabs().foreach(function(tab)
                local name = tab.name()
                local index = string.find(name, "%[%d")
                local tab_name = index and string.sub(name, 1, index - 1) or name
                local hl = tab.is_current() and theme.current_tab or theme.tab
                local modified = false
                local win_ids = require("tabby.module.api").get_tab_wins(tab.id)
                for _, win_id in ipairs(win_ids) do
                    if pcall(vim.api.nvim_win_get_buf, win_id) then
                        local bufid = vim.api.nvim_win_get_buf(win_id)
                        if vim.api.nvim_get_option_value("modified", { buf = bufid }) then
                            modified = true
                            break
                        end
                    end
                end

                return {
                    line.sep("", hl, theme.fill),
                    tab.number(),
                    "  " .. tab_name,
                    modified and "",
                    tab.close_btn(""),
                    line.sep("", hl, theme.fill),
                    hl = hl,
                    margin = " ",
                }
            end),
            line.spacer(),
            line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
                return {
                    line.sep("", theme.win, theme.fill),
                    win.is_current() and "" or "",
                    win.buf_name(),
                    line.sep("", theme.win, theme.fill),
                    hl = theme.win,
                    margin = " ",
                }
            end),
            {
                line.sep("", theme.tail, theme.fill),
                { "  ", hl = theme.tail },
            },
            hl = theme.fill,
        }
    end,
})
