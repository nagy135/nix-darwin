local hs = hs
local chooser = require("utils.chooser")
local prompt = require("utils.prompt")

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
			table.insert(choices, chooser.createStyledChoice(
				key,
				valueType == "table" and "Open nested credentials" or "Copy credential to clipboard",
				{
				valueType = valueType,
				value = value,
				key = key,
			}
			))
		end
	end

	table.sort(choices, function(left, right)
		return left.key:lower() < right.key:lower()
	end)

	return choices
end

local function showSecretChooser(entries, title, focusedWindow)
	local choices = buildSecretChoices(entries)
	if #choices == 0 then
		hs.alert.show("No credentials found")
		prompt.focusWindow(focusedWindow)
		return
	end

	chooser.showSearchableList({
		choices = choices,
		searchSubText = true,
		placeholder = title,
		rows = math.min(#choices, 10),
		width = 30,
		onChoose = function(choice, picker)
			if not choice then
				prompt.focusWindow(focusedWindow)
				return
			end

			if choice.valueType == "table" then
				picker:hide()
				hs.timer.doAfter(0.1, function()
					showSecretChooser(choice.value, title .. " / " .. choice.key, focusedWindow)
				end)
				return
			end

			hs.pasteboard.setContents(choice.value)
			hs.alert.show("Copied " .. choice.key)
			prompt.focusWindow(focusedWindow)
		end,
	})
end

local function copySecretToClipboard()
	prompt.withFocusedWindow(function(focusedWindow)
		local secrets, err = readSecretsFile()
		if not secrets then
			hs.alert.show(err)
			prompt.focusWindow(focusedWindow)
			return
		end

		showSecretChooser(secrets, "search credentials", focusedWindow)
	end)
end

local function copyTextToClipboard()
	prompt.copyPrompt("Clipboard", "Text to copy", "Copy")
end

return {
	{ mods = { "alt" }, key = "g", description = "Copy typed text to clipboard", fn = copyTextToClipboard },
	{ mods = { "cmd", "alt" }, key = "p", description = "Copy credential from secrets file", fn = copySecretToClipboard },
}
