local hs = hs

local function keyStroke(key)
	return function()
		hs.eventtap.keyStroke(nil, key, 0)
	end
end

local function helloWorld()
	hs.alert.show("Hello World!")
end

local leftArrow = keyStroke("left")
local downArrow = keyStroke("down")
local upArrow = keyStroke("up")
local rightArrow = keyStroke("right")

return {
	{ mods = { "cmd", "alt", "ctrl" }, key = "W", description = "Show Hello World alert", fn = helloWorld },
	{ mods = { "cmd", "alt" }, key = "h", description = "Send left arrow", fn = leftArrow, repeatFn = leftArrow },
	{ mods = { "cmd", "alt" }, key = "j", description = "Send down arrow", fn = downArrow, repeatFn = downArrow },
	{ mods = { "cmd", "alt" }, key = "k", description = "Send up arrow", fn = upArrow, repeatFn = upArrow },
	{ mods = { "cmd", "alt" }, key = "l", description = "Send right arrow", fn = rightArrow, repeatFn = rightArrow },
}
