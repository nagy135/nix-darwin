require("hs.ipc")
local hs = hs

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
	local functionRun = function()
		hs.eventtap.keyStroke(bind.to_mod, bind.to_key, 0)
	end
	hs.hotkey.bind(bind.from_mod, bind.from_key, functionRun, nil, functionRun)
end

-- -- open Arc
-- hs.hotkey.bind({ "cmd", "ctrl" }, "a", function()
-- 	hs.osascript.applescriptFromFile("arcswitcher.applescript")
-- end)

-- layout switcher {{{
local layoutSwitcher = function()
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
end

hs.hotkey.bind({ "ctrl" }, "space", layoutSwitcher)
-- }}}

-- Run clipboard image resizer script
hs.hotkey.bind({ "alt", "shift" }, "i", function()
	local output = hs.execute("~/.scripts/macos_clipboard_image_smaller.sh")
	hs.alert.show(output)
end)

-- tabber {{{
-- Run clipboard tabber grab
hs.hotkey.bind({ "alt", "shift" }, "g", function()
	hs.execute("~/.scripts/tabber")
end)

-- Run clipboard tabber process
hs.hotkey.bind({ "alt", "shift" }, "p", function()
	hs.execute("~/.scripts/tabber process")
end)
-- }}}

-- Bang search hotkey
hs.hotkey.bind({ "alt", "shift" }, "s", function()
	local btn, input = hs.dialog.textPrompt("Bang Search", "Enter command", "", "Search", "Cancel")

	if btn ~= "Search" or not input or input == "" then
		return
	end

	-- Define bang mappings
	local bangs = {
		you = "https://www.youtube.com/results?search_query=%s",
		gh = "https://github.com/search?q=%s",
		g = "https://www.google.com/search?q=%s",
		ddg = "https://duckduckgo.com/?q=%s",
		sp = "https://open.spotify.com/search/%s",
		ama = "https://www.amazon.com/s?k=%s",
		nix = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=%s",
		npm = "https://www.npmjs.com/search?q=%s",
		chat = "https://chatgpt.com?q=%s",
		gemini = "https://www.google.com/search?udm=50&source=searchlabs&q=%s",
		maps = "https://www.google.com/maps/search/%s",
	}

	local bang, query = input:match("^!(%S+)%s+(.+)$")

	if bang and query then
		local template = bangs[bang]
		if template then
			local escaped = hs.http.encodeForQuery(query)
			local url = string.format(template, escaped)
			hs.urlevent.openURL(url)
			return
		end
	end

	-- Fallback → open ChatGPT with full text
	local escaped = hs.http.encodeForQuery(input)
	hs.urlevent.openURL("https://chatgpt.com?q=" .. escaped)
end)

-- -- Prompt → search in browser
-- hs.hotkey.bind({ "alt", "shift" }, "a", function()
-- 	local btn, query = hs.dialog.textPrompt("Web Search", "Ask ChatGPT", "", "Search", "Cancel")
--
-- 	if btn == "Search" and query and query ~= "" then
-- 		local escaped = hs.http.encodeForQuery(query)
-- 		local url = "https://chatgpt.com?q=" .. escaped
-- 		hs.urlevent.openURL(url)
-- 	end
-- end)

-- just open chatgpt
hs.hotkey.bind({ "alt", "ctrl" }, "a", function()
	local url = "https://chatgpt.com"
	hs.urlevent.openURL(url)
end)

-- Translate DE => EN
hs.hotkey.bind({ "alt", "shift" }, "t", function()
	local btn, query = hs.dialog.textPrompt("DE => EN", "German", "", "Translate", "Cancel")

	if btn == "Translate" and query and query ~= "" then
		local escaped = hs.http.encodeForQuery(query)
		local url = "https://translate.google.com/?sl=de&tl=en&text=" .. escaped .. "&op=translate"
		hs.urlevent.openURL(url)
	end
end)

-- Translate EN => DE
hs.hotkey.bind({ "alt", "ctrl" }, "t", function()
	local btn, query = hs.dialog.textPrompt("EN => DE", "English", "", "Translate", "Cancel")

	if btn == "Translate" and query and query ~= "" then
		local escaped = hs.http.encodeForQuery(query)
		local url = "https://translate.google.com/?sl=en&tl=de&text=" .. escaped .. "&op=translate"
		hs.urlevent.openURL(url)
	end
end)

hs.hotkey.bind({ "alt", "shift", "ctrl" }, "t", function()
	local btn, query = hs.dialog.textPrompt("Artikel finder", "der/die/das", "", "Find", "Cancel")

	if btn == "Find" and query and query ~= "" then
		local escaped = hs.http.encodeForQuery(query)
		local url = "https://www.verbformen.de/deklination/substantive/" .. escaped .. ".htm"
		hs.urlevent.openURL(url)
	end
end)

hs.hotkey.bind({ "alt" }, "t", function()
	local btn, query = hs.dialog.textPrompt("Translate (konjugation)", "dictionary", "", "Translate", "Cancel")

	if btn == "Translate" and query and query ~= "" then
		local escaped = hs.http.encodeForQuery(query)
		local url = "https://www.verbformen.de/konjugation/?w=" .. escaped
		hs.urlevent.openURL(url)
	end
end)

-- -- Create a simple webview
-- local myView = hs.webview.newBrowser(hs.geometry.rect(300, 300, 400, 400))
-- myView:html("<html><body><h1>Hello</h1></body></html>")
-- myView:show()
--
-- -- Callback when user presses a button in the alert
-- local function alertCallback(result)
-- 	hs.alert.show("You pressed: " .. result)
-- end
--
-- -- Show alert inside the webview
-- hs.dialog.webviewAlert(
-- 	myView, -- webview
-- 	alertCallback, -- callback
-- 	"Do you want to continue?", -- message
-- 	"This is displayed inside the webview.", -- informative text
-- 	"Yes", -- button one label
-- 	"No", -- button two label
-- 	"informational" -- style
-- )
