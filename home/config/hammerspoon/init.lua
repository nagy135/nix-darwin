require("hs.ipc")

local hotkeyUtils = require("utils.hotkeys")

local hotkeys = {}

local function appendBindings(bindings)
	for _, binding in ipairs(bindings) do
		table.insert(hotkeys, binding)
	end
end

appendBindings(require("bindings.navigation"))
appendBindings(require("bindings.layout"))
appendBindings(require("bindings.scripts"))
appendBindings(require("bindings.search"))
appendBindings(require("bindings.clipboard"))
appendBindings(require("bindings.language"))

table.insert(hotkeys, hotkeyUtils.createPickerBinding(hotkeys))
hotkeyUtils.bindAll(hotkeys)
