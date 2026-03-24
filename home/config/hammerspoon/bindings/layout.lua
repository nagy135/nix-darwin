local hs = hs
local chooserUtils = require("utils.chooser")

local function layoutSwitcher()
	local chooser = hs.chooser.new(function(choice)
		if not choice then
			local current = hs.keycodes.currentSourceID()
			hs.alert.show("keeping " .. current:match("([^%.]+)$"))
			return
		end

		hs.keycodes.setLayout(choice.layout)
		hs.alert.show(choice.layout)
	end)

	local layouts = hs.keycodes.layouts()
	local choices = {}
	for index, layout in ipairs(layouts) do
		choices[index] = chooserUtils.createStyledChoice(layout, layout:gsub("%.", ""), { layout = layout })
	end

	chooser:choices(choices)
	chooser:searchSubText(true)
	chooser:placeholderText("select layout")
	chooser:rows(#choices)
	chooser:width(20)
	chooser:show()
end

return {
	{ mods = { "ctrl" }, key = "space", description = "Open keyboard layout picker", fn = layoutSwitcher },
}
