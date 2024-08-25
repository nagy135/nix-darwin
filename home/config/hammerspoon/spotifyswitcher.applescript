if application "Spotify" is running then
	tell application "Spotify"
		if (count every window) = 0 then
			make new window
		else
			reopen
			activate
		end if
	end tell
else
	tell application "Spotify"
		activate
	end tell
end if
