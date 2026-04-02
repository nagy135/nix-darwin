local hs = hs
local prompt = require("utils.prompt")

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

local function bangSearch()
	prompt.openPrompt({
		title = "Bang Search",
		message = "Enter command",
		confirm = "Search",
		onConfirm = function(input)
			local bang, query = input:match("^!(%S+)%s+(.+)$")
			if bang and query and bangs[bang] then
				local escaped = hs.http.encodeForQuery(query)
				hs.urlevent.openURL(string.format(bangs[bang], escaped))
				return
			end

			hs.urlevent.openURL("https://www.google.com/search?q=" .. hs.http.encodeForQuery(input))
		end,
	})
end

return {
	{ mods = { "alt", "shift" }, key = "s", description = "Open bang search prompt", fn = bangSearch },
}
