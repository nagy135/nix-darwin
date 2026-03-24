local hs = hs
local chooser = require("utils.chooser")

local M = {}

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
		hs.hotkey.bind(hotkey.mods, hotkey.key, hotkey.fn, nil, hotkey.repeatFn)
	end
end

function M.createPickerBinding(hotkeys)
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
				table.insert(choices, chooser.createStyledChoice(hotkey.description, bind, { uuid = uuid }))
			end
		end

		return choices
	end

	local function showHotkeyPicker()
		local picker
		picker = hs.chooser.new(function(choice)
			if not choice then
				return
			end

			local hotkey = hotkeyChoiceMap[choice.uuid]
			if hotkey then
				picker:hide()
				hs.timer.doAfter(0.1, hotkey.fn)
			end
		end)

		picker:choices(buildHotkeyChoices(""))
		picker:queryChangedCallback(function(query)
			picker:choices(buildHotkeyChoices(query))
		end)
		picker:searchSubText(false)
		picker:placeholderText("search hotkeys by bind or description")
		picker:rows(math.min(#hotkeys, 8))
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
