local hs = hs
local chooser = require("utils.chooser")

local M = {}

local raycastKeybindsPath = os.getenv("HOME") .. "/.dots/raycast/raycast-keybinds-keybinds.json"

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

function M.bindAll(hotkeys)
	for _, hotkey in ipairs(hotkeys) do
		if hotkey.fn then
			hs.hotkey.bind(hotkey.mods, hotkey.key, hotkey.fn, nil, hotkey.repeatFn)
		end
	end
end

local function loadRaycastKeybinds()
	if not hs.fs.attributes(raycastKeybindsPath) then
		return {}
	end

	local file = io.open(raycastKeybindsPath, "r")
	if not file then
		return {}
	end

	local contents = file:read("*a")
	file:close()

	local keybinds = hs.json.decode(contents)
	if type(keybinds) ~= "table" then
		return {}
	end

	local entries = {}
	for description, bind in pairs(keybinds) do
		if type(description) == "string" and type(bind) == "string" then
			table.insert(entries, {
				description = "Raycast: " .. description,
				bind = bind,
			})
		end
	end

	table.sort(entries, function(left, right)
		return left.description:lower() < right.description:lower()
	end)

	return entries
end

function M.createPickerBinding(hotkeys)
	local hotkeyChoiceMap = {}

	local function buildHotkeyChoices(query, raycastKeybinds)
		local normalizedQuery = query and query:lower() or ""
		local choices = {}
		hotkeyChoiceMap = {}

		local function addChoice(entry, uuid)
			local bind = entry.bind or formatBind(entry.mods, entry.key)
			local haystack = (bind .. " " .. entry.description):lower()

			if normalizedQuery == "" or haystack:find(normalizedQuery, 1, true) then
				hotkeyChoiceMap[uuid] = entry
				table.insert(choices, chooser.createStyledChoice(entry.description, bind, { uuid = uuid }))
			end
		end

		for index, hotkey in ipairs(hotkeys) do
			addChoice(hotkey, "hotkey-" .. index)
		end

		for index, raycastKeybind in ipairs(raycastKeybinds) do
			addChoice(raycastKeybind, "raycast-" .. index)
		end

		return choices
	end

	local function showHotkeyPicker()
		local raycastKeybinds = loadRaycastKeybinds()
		local picker
		picker = hs.chooser.new(function(choice)
			if not choice then
				return
			end

			local hotkey = hotkeyChoiceMap[choice.uuid]
			if hotkey then
				picker:hide()
				if hotkey.fn then
					hs.timer.doAfter(0.1, hotkey.fn)
				end
			end
		end)

		picker:choices(buildHotkeyChoices("", raycastKeybinds))
		picker:queryChangedCallback(function(query)
			picker:choices(buildHotkeyChoices(query, raycastKeybinds))
		end)
		picker:searchSubText(false)
		picker:placeholderText("search hotkeys by bind or description")
		picker:rows(math.min(#hotkeys + #raycastKeybinds, 8))
		picker:width(30)
		picker:show()
	end

	return {
		mods = { "alt", "shift" },
		key = "k",
		description = "Open hotkey picker",
		fn = showHotkeyPicker,
	}
end

return M
