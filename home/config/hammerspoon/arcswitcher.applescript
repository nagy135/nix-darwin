if application "Arc" is running then
	tell application "Arc"
		if (count every window) = 0 then
			make new window
		else
			reopen
			activate
		end if
	end tell
else
	tell application "Arc"
		activate
	end tell
end if
