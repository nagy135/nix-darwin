local hs = hs

local M = {}

local defaultArgs = {
	"--override",
	"remember_window_size=no",
	"--override",
	"initial_window_width=80c",
	"--override",
	"initial_window_height=18c",
}

local function shellQuote(value)
	return "'" .. tostring(value):gsub("'", "'\\''") .. "'"
end

local function appendArgs(parts, args)
	for _, arg in ipairs(args) do
		table.insert(parts, shellQuote(arg))
	end
end

function M.open(args)
	local parts = { "open", "-na", "kitty", "--args" }
	appendArgs(parts, defaultArgs)
	appendArgs(parts, args or {})
	hs.execute(table.concat(parts, " "))
end

function M.openDnd(contents)
	M.open({ "kitten", "dnd", contents })
end

function M.openPiPrompt(piPrompt)
	M.open({
		"--start-as=maximized",
		"--directory=" .. os.getenv("HOME") .. "/Code/nix-darwin",
		"zsh",
		"-ic",
		"echo 'Correcting German sentence…'; echo; p \"$1\" | tee >(sed -n '1p' | pbcopy); echo; exec zsh -i",
		"pi-prompt",
		piPrompt,
	})
end

return M
