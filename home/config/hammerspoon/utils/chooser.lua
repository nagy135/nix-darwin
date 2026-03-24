local hs = hs

local M = {}

local chooserTextStyle = {
	font = {
		name = "Mononoki Nerd Font Propo Regular",
		size = 16,
	},
}

local chooserSubTextStyle = {
	font = {
		name = "Mononoki Nerd Font Mono Regular",
		size = 11,
	},
}

function M.createStyledChoice(text, subText, extra)
	local choice = extra or {}
	choice.text = hs.styledtext.new(text, chooserTextStyle)
	choice.subText = hs.styledtext.new(subText, chooserSubTextStyle)
	return choice
end

function M.showSearchableList(config)
	local chooser
	chooser = hs.chooser.new(function(choice)
		config.onChoose(choice, chooser)
	end)

	chooser:choices(config.choices)
	chooser:searchSubText(config.searchSubText == true)
	chooser:placeholderText(config.placeholder or "search")
	chooser:rows(config.rows or math.min(#config.choices, 8))
	chooser:width(config.width or 30)
	chooser:show()

	return chooser
end

return M
