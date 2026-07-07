local hs = hs
local kitty = require("utils.kitty")
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

local function correctGermanWithPi()
	local germanCorrectionPrefix =
		"You will correct my German sentence. Reply in plain text only, with no Markdown and no labels. The first line must be only the corrected sentence. Then break down every mistake in English. Afterwards give me a more idiomatic version if such exists. Keep casing and style of the sentence, dont capitalize, dont add dot at the end, just fix the words (you can add commas, capitalize nouns etc just make sure it fits still in the sentence it was taken out of). Sentence follows:"

	prompt.openPrompt({
		title = "German correction",
		message = "Sentence",
		confirm = "Correct",
		restoreFocus = false,
		onConfirm = function(sentence)
			kitty.openPiPrompt(germanCorrectionPrefix .. "\n\n" .. sentence)
		end,
	})
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
	{
		mods = { "cmd", "alt" },
		key = "t",
		description = "Correct German sentence with pi",
		fn = correctGermanWithPi,
	},
}
