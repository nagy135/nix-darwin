local hs = hs

local function resizeClipboardImage()
	local output = hs.execute("~/.scripts/macos_clipboard_image_smaller.sh")
	hs.alert.show(output)
end

local function runTabberGrab()
	hs.execute("~/.scripts/tabber")
end

local function runTabberProcess()
	hs.execute("~/.scripts/tabber process")
end

return {
	{ mods = { "alt", "shift" }, key = "i", description = "Resize clipboard image", fn = resizeClipboardImage },
	{ mods = { "alt", "shift" }, key = "g", description = "Run tabber grab", fn = runTabberGrab },
	{ mods = { "alt", "shift" }, key = "p", description = "Run tabber process", fn = runTabberProcess },
}
