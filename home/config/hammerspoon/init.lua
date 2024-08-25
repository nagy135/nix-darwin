hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "W", function()
	hs.alert.show("Hello World!")
end)


local binds = {
	{ from_mod = { "cmd", "alt" }, from_key = "h", to_mod = nil, to_key = "left" },
	{ from_mod = { "cmd", "alt" }, from_key = "j", to_mod = nil, to_key = "down" },
	{ from_mod = { "cmd", "alt" }, from_key = "k", to_mod = nil, to_key = "up" },
	{ from_mod = { "cmd", "alt" }, from_key = "l", to_mod = nil, to_key = "right" },
}
for _, bind in ipairs(binds) do
	hs.hotkey.bind(bind.from_mod, bind.from_key, function()
		hs.eventtap.keyStroke(bind.to_mod, bind.to_key, 0)
	end)
end
