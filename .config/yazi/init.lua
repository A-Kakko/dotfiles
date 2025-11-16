require("full-border"):setup()
require("git"):setup()

function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = ""
	elseif os.date("%Y", time) == os.date("%Y") then
		time = os.date("%m/%d %H:%M", time)
	else
		time = os.date("%Y/%m/%d", time)
	end

	local size = self._file:size()
	return string.format("%s %s", time, size and ya.readable_size(size) or "-")
end

Status:children_add(function(self)
	local h = self._current.hovered
	local symlink = ""
	if h and h.link_to then
		symlink = " -> " .. tostring(h.link_to)
	else
		symlink = ""
	end
	return ui.Line({
		ui.Span(symlink):fg("#af87ff"),
		" [",
		ui.Span(os.date("%Y-%m-%d %H:%M", tostring(h.cha.mtime):sub(1, 10))):fg("#af87ff"),
		"] ",
	})
end, 3300, Status.LEFT)

Status:children_add(function()
	local h = cx.active.current.hovered
	if h == nil or ya.target_family() ~= "unix" then
		return ""
	end

	return ui.Line({
		"[",
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("#af87ff"),
		":",
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("#af87ff"),
		"]",
		" ",
	})
end, 500, Status.RIGHT)
