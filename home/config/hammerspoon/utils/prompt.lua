local hs = hs

local M = {}

local hammerspoonBundleId = "org.hammerspoon.Hammerspoon"

function M.withFocusedWindow(action)
	local focusedWindow = hs.window.frontmostWindow()
	action(focusedWindow)
end

function M.focusWindow(window)
	if window then
		window:focus()
	end
end

local function restoreWindowIfHammerspoonFrontmost(window)
	hs.timer.doAfter(0.1, function()
		local frontmostApp = hs.application.frontmostApplication()
		if frontmostApp and frontmostApp:bundleID() == hammerspoonBundleId then
			M.focusWindow(window)
		end
	end)
end

function M.copyPrompt(title, message, button, opts)
	opts = opts or {}
	M.withFocusedWindow(function(focusedWindow)
		local btn, input = hs.dialog.textPrompt(title, message, "", button, "Cancel")
		local shouldPaste = btn == button and input ~= nil and opts.paste

		if btn == button and input ~= nil then
			hs.pasteboard.setContents(input)
			if not shouldPaste then
				hs.alert.show("Copied to clipboard")
			end
		end

		M.focusWindow(focusedWindow)

		if shouldPaste then
			hs.timer.doAfter(0.1, function()
				hs.eventtap.keyStroke({ "cmd" }, "v")
			end)
		end
	end)
end

function M.openPrompt(config)
	M.withFocusedWindow(function(focusedWindow)
		local btn, query = hs.dialog.textPrompt(config.title, config.message, "", config.confirm, "Cancel")
		if btn == config.confirm and query and query ~= "" then
			config.onConfirm(query)
			if config.restoreFocus ~= false then
				restoreWindowIfHammerspoonFrontmost(focusedWindow)
			end
			return
		end

		M.focusWindow(focusedWindow)
	end)
end

return M
