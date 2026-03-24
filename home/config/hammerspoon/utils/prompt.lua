local hs = hs

local M = {}

function M.withFocusedWindow(action)
	local focusedWindow = hs.window.frontmostWindow()
	action(focusedWindow)
end

function M.focusWindow(window)
	if window then
		window:focus()
	end
end

function M.copyPrompt(title, message, button)
	M.withFocusedWindow(function(focusedWindow)
		local btn, input = hs.dialog.textPrompt(title, message, "", button, "Cancel")

		if btn == button and input ~= nil then
			hs.pasteboard.setContents(input)
			hs.alert.show("Copied to clipboard")
		end

		M.focusWindow(focusedWindow)
	end)
end

function M.openPrompt(config)
	local btn, query = hs.dialog.textPrompt(config.title, config.message, "", config.confirm, "Cancel")
	if btn == config.confirm and query and query ~= "" then
		config.onConfirm(query)
	end
end

return M
