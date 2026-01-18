---@diagnostic disable: undefined-global
th.git = th.git or {}

th.git.modified_sign = ""
th.git.added_sign = ""
th.git.untracked_sign = "?"
th.git.ignored_sign = ""
th.git.deleted_sign = ""
th.git.updated_sign = ""

local bookmarks = {}

table.insert(bookmarks, {
  tag = "dotfiles",
  path = os.getenv("WORKSPACE") .. '/dotfiles/',
  key = "d"
})

require("yaziline"):setup({
    bookmarks = bookmarks,
    color = "#89b4fa",
    secondary_color = "#313244",
	separator_style = "angly",
	select_symbol = "",
	yank_symbol = "󰆐",
	filename_max_length = 24,
	filename_trim_length = 6,
})

Status:children_add(function()
	local h = cx.active.current.hovered
	if h == nil or ya.target_family() ~= "unix" then
		return ui.Line {}
	end

	return ui.Line {
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		ui.Span(":"),
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		ui.Span(" "),
	}
end, 500, Status.RIGHT)

require("yamb"):setup {
  bookmarks = bookmarks,
  jump_notify = true,
  cli = "fzf",
  path = os.getenv("XDG_CONFIG_HOME") .. "/yazi/bookmarks",
}
require("git"):setup()
require("smart-enter"):setup({
    open_multi = true,
})
