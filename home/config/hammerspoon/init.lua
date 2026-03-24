require("hs.ipc")
local hs = hs

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

local function helloWorld()
	hs.alert.show("Hello World!")
end

local function leftArrow()
	hs.eventtap.keyStroke(nil, "left", 0)
end

local function downArrow()
	hs.eventtap.keyStroke(nil, "down", 0)
end

local function upArrow()
	hs.eventtap.keyStroke(nil, "up", 0)
end

local function rightArrow()
	hs.eventtap.keyStroke(nil, "right", 0)
end

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

local function bangSearch()
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
end

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
-- hs.hotkey.bind({ "alt", "ctrl" }, "a", function()
-- 	local url = "https://chatgpt.com"
-- 	hs.urlevent.openURL(url)
-- end)

-- Translate DE => EN
local function translateDeToEn()
	local btn, query = hs.dialog.textPrompt("DE => EN", "German", "", "Translate", "Cancel")

	if btn == "Translate" and query and query ~= "" then
		local escaped = hs.http.encodeForQuery(query)
		local url = "https://translate.google.com/?sl=de&tl=en&text=" .. escaped .. "&op=translate"
		hs.urlevent.openURL(url)
	end
end

-- Translate EN => DE
local function translateEnToDe()
	local btn, query = hs.dialog.textPrompt("EN => DE", "English", "", "Translate", "Cancel")

	if btn == "Translate" and query and query ~= "" then
		local escaped = hs.http.encodeForQuery(query)
		local url = "https://translate.google.com/?sl=en&tl=de&text=" .. escaped .. "&op=translate"
		hs.urlevent.openURL(url)
	end
end

local function findGermanArticle()
	local btn, query = hs.dialog.textPrompt("Artikel finder", "der/die/das", "", "Find", "Cancel")

	if btn == "Find" and query and query ~= "" then
		local escaped = hs.http.encodeForQuery(query)
		local url = "https://www.verbformen.de/deklination/substantive/" .. escaped .. ".htm"
		hs.urlevent.openURL(url)
	end
end

local function openGermanConjugationLookup()
	local btn, query = hs.dialog.textPrompt("Translate (konjugation)", "dictionary", "", "Translate", "Cancel")

	if btn == "Translate" and query and query ~= "" then
		local escaped = hs.http.encodeForQuery(query)
		local url = "https://www.verbformen.de/konjugation/?w=" .. escaped
		hs.urlevent.openURL(url)
	end
end

local function copyTextToClipboard()
	local focusedWindow = hs.window.frontmostWindow()
	local btn, input = hs.dialog.textPrompt("Clipboard", "Text to copy", "", "Copy", "Cancel")

	if btn == "Copy" and input ~= nil then
		hs.pasteboard.setContents(input)
		hs.alert.show("Copied to clipboard")
	end

	if focusedWindow then
		focusedWindow:focus()
	end
end

local function readSecretsFile()
	local path = os.getenv("HOME") .. "/.secrets.json"
	local file, err = io.open(path, "r")
	if not file then
		return nil, "Could not open " .. path .. ": " .. tostring(err)
	end

	local contents = file:read("*a")
	file:close()

	local decoded, decodeErr = hs.json.decode(contents)
	if type(decoded) ~= "table" then
		return nil, decodeErr or "Secrets file must contain a JSON object"
	end

	return decoded
end

local function buildSecretChoices(entries)
	local choices = {}

	for key, value in pairs(entries) do
		local valueType = type(value)
		if valueType == "string" or valueType == "table" then
			table.insert(choices, {
				text = key,
				subText = valueType == "table" and "Open nested credentials" or "Copy credential to clipboard",
				valueType = valueType,
				value = value,
			})
		end
	end

	table.sort(choices, function(left, right)
		return left.text:lower() < right.text:lower()
	end)

	return choices
end

local function showSecretChooser(entries, title, focusedWindow)
	local chooser
	chooser = hs.chooser.new(function(choice)
		if not choice then
			if focusedWindow then
				focusedWindow:focus()
			end
			return
		end

		if choice.valueType == "table" then
			chooser:hide()
			hs.timer.doAfter(0.1, function()
				showSecretChooser(choice.value, title .. " / " .. choice.text, focusedWindow)
			end)
			return
		end

		hs.pasteboard.setContents(choice.value)
		hs.alert.show("Copied " .. choice.text)

		if focusedWindow then
			focusedWindow:focus()
		end
	end)

	local choices = buildSecretChoices(entries)
	if #choices == 0 then
		hs.alert.show("No credentials found")
		if focusedWindow then
			focusedWindow:focus()
		end
		return
	end

	chooser:choices(choices)
	chooser:searchSubText(true)
	chooser:placeholderText(title)
	chooser:rows(math.min(#choices, 10))
	chooser:width(30)
	chooser:show()
end

local function copySecretToClipboard()
	local focusedWindow = hs.window.frontmostWindow()
	local secrets, err = readSecretsFile()

	if not secrets then
		hs.alert.show(err)
		if focusedWindow then
			focusedWindow:focus()
		end
		return
	end

	showSecretChooser(secrets, "search credentials", focusedWindow)
end

local function formatMods(mods)
	local labels = {
		cmd = "cmd",
		ctrl = "ctrl",
		alt = "alt",
		shift = "shift",
	}
	local parts = {}
	for _, mod in ipairs(mods) do
		table.insert(parts, labels[mod] or mod)
	end
	return table.concat(parts, "+")
end

local function formatBind(mods, key)
	local prefix = #mods > 0 and (formatMods(mods) .. "+") or ""
	return prefix .. key
end

local chooserTextStyle = {
	font = {
		name = "SF Pro Text",
		size = 16,
	},
}

local chooserSubTextStyle = {
	font = {
		name = "SF Pro Text",
		size = 11,
	},
}

local hotkeys = {
	{ mods = { "cmd", "alt", "ctrl" }, key = "W", description = "Show Hello World alert", fn = helloWorld },
	{ mods = { "cmd", "alt" }, key = "h", description = "Send left arrow", fn = leftArrow, repeatFn = leftArrow },
	{ mods = { "cmd", "alt" }, key = "j", description = "Send down arrow", fn = downArrow, repeatFn = downArrow },
	{ mods = { "cmd", "alt" }, key = "k", description = "Send up arrow", fn = upArrow, repeatFn = upArrow },
	{ mods = { "cmd", "alt" }, key = "l", description = "Send right arrow", fn = rightArrow, repeatFn = rightArrow },
	{ mods = { "ctrl" }, key = "space", description = "Open keyboard layout picker", fn = layoutSwitcher },
	{ mods = { "alt", "shift" }, key = "i", description = "Resize clipboard image", fn = resizeClipboardImage },
	{ mods = { "alt", "shift" }, key = "g", description = "Run tabber grab", fn = runTabberGrab },
	{ mods = { "alt", "shift" }, key = "p", description = "Run tabber process", fn = runTabberProcess },
	{ mods = { "alt", "shift" }, key = "s", description = "Open bang search prompt", fn = bangSearch },
	{ mods = { "alt" }, key = "g", description = "Copy typed text to clipboard", fn = copyTextToClipboard },
	{ mods = { "cmd", "alt" }, key = "p", description = "Copy credential from secrets file", fn = copySecretToClipboard },
	{ mods = { "alt", "shift" }, key = "t", description = "Translate German to English", fn = translateDeToEn },
	{ mods = { "alt", "ctrl" }, key = "t", description = "Translate English to German", fn = translateEnToDe },
	{ mods = { "alt", "shift", "ctrl" }, key = "t", description = "Find German article", fn = findGermanArticle },
	{ mods = { "alt" }, key = "t", description = "Open German conjugation lookup", fn = openGermanConjugationLookup },
}

local hotkeyChoiceMap = {}

local function buildHotkeyChoices(query)
	local normalizedQuery = query and query:lower() or ""
	local choices = {}
	hotkeyChoiceMap = {}

	for index, hotkey in ipairs(hotkeys) do
		local bind = formatBind(hotkey.mods, hotkey.key)
		local haystack = (bind .. " " .. hotkey.description):lower()

		if normalizedQuery == "" or haystack:find(normalizedQuery, 1, true) then
			local uuid = tostring(index)
			hotkeyChoiceMap[uuid] = hotkey
			table.insert(choices, {
				text = hs.styledtext.new(hotkey.description, chooserTextStyle),
				subText = hs.styledtext.new(bind, chooserSubTextStyle),
				uuid = uuid,
			})
		end
	end

	return choices
end

local function showHotkeyPicker()
	local chooser
	chooser = hs.chooser.new(function(choice)
		if not choice then
			return
		end
		local hotkey = hotkeyChoiceMap[choice.uuid]
		if hotkey then
			chooser:hide()
			hs.timer.doAfter(0.1, hotkey.fn)
		end
	end)

	chooser:choices(buildHotkeyChoices(""))
	chooser:queryChangedCallback(function(query)
		chooser:choices(buildHotkeyChoices(query))
	end)
	chooser:searchSubText(false)
	chooser:placeholderText("search hotkeys by bind or description")
	chooser:rows(math.min(#hotkeys, 8))
	chooser:width(30)
	chooser:show()
end

table.insert(hotkeys, {
	mods = { "alt", "shift" },
	key = "k",
	description = "Open hotkey picker",
	fn = showHotkeyPicker,
})

for _, hotkey in ipairs(hotkeys) do
	hs.hotkey.bind(hotkey.mods, hotkey.key, hotkey.fn, nil, hotkey.repeatFn)
end
-- }}}

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
