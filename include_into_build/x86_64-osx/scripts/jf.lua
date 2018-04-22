return function()
	local pos1 = go.get_position()
	local pos2 = go.get_position()
	pos2.y = pos2.y + 40

	while true do
		wait.go_animate(".", "position", go.PLAYBACK_ONCE_FORWARD, pos2, go.EASING_OUTSINE, 0.5)
		wait.go_animate(".", "position", go.PLAYBACK_ONCE_FORWARD, pos1, go.EASING_LINEAR, 2)
	end	
end