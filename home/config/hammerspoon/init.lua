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


-- open Arc
hs.hotkey.bind({ "cmd", "ctrl" }, "a", function()
	hs.osascript.applescriptFromFile('arcswitcher.applescript')
end)

--- open Spotify
hs.hotkey.bind({ "alt" }, "m", function()
	hs.osascript.applescriptFromFile('spotifyswitcher.applescript')
end)


hs.hotkey.bind({ "ctrl" }, "space", function()
	local chooser = hs.chooser.new(function(choice)
		if not choice then
			local current = hs.keycodes.currentSourceID()
			hs.alert.show("keeping " .. current:match("([^%.]+)$"))
			return
		end
		hs.keycodes.setLayout(choice.text)
		hs.alert.show(choice.text)
	end)

	local layouts = hs.keycodes.layouts()
	local choices = {}
	for i, layout in ipairs(layouts) do
		choices[i] = {
			text = layout,
			subText = layout:gsub("%.", ""),
		}
	end

	chooser:choices(choices)

	chooser:searchSubText(true)
	chooser:placeholderText("select layout")
	chooser:rows(#choices)
	chooser:width(20)

	chooser:show()
end)
