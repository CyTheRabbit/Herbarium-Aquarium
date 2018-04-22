return function()

	go.set("bkg", "euler", vmath.vector3(0, 0, -2.5))
	go.animate("bkg", "euler", go.PLAYBACK_LOOP_PINGPONG, vmath.vector3(0, 0, 2.5), go.EASING_INOUTSINE, 10)
	go.animate("bkg", "position", go.PLAYBACK_ONCE_PINGPONG, vmath.vector3(15, 0, 0), go.EASING_INOUTSINE, 8)
end