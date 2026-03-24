local hs = hs
local prompt = require("utils.prompt")

local function openUrlPrompt(title, message, confirm, buildUrl)
	return function()
		prompt.openPrompt({
			title = title,
			message = message,
			confirm = confirm,
			onConfirm = function(query)
				hs.urlevent.openURL(buildUrl(hs.http.encodeForQuery(query)))
			end,
		})
	end
end

return {
	{
		mods = { "alt", "shift" },
		key = "t",
		description = "Translate German to English",
		fn = openUrlPrompt("DE => EN", "German", "Translate", function(query)
			return "https://translate.google.com/?sl=de&tl=en&text=" .. query .. "&op=translate"
		end),
	},
	{
		mods = { "alt", "ctrl" },
		key = "t",
		description = "Translate English to German",
		fn = openUrlPrompt("EN => DE", "English", "Translate", function(query)
			return "https://translate.google.com/?sl=en&tl=de&text=" .. query .. "&op=translate"
		end),
	},
	{
		mods = { "alt", "shift", "ctrl" },
		key = "t",
		description = "Find German article",
		fn = openUrlPrompt("Artikel finder", "der/die/das", "Find", function(query)
			return "https://www.verbformen.de/deklination/substantive/" .. query .. ".htm"
		end),
	},
	{
		mods = { "alt" },
		key = "t",
		description = "Open German conjugation lookup",
		fn = openUrlPrompt("Translate (konjugation)", "dictionary", "Translate", function(query)
			return "https://www.verbformen.de/konjugation/?w=" .. query
		end),
	},
}
