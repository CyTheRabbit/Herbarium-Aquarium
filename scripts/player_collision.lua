return function()
	while true do
		local message_id, message = wait.until_message(hash "collision_response")
		if message.other_group == hash "enemy" then
			global.score = global.score - 1
			particlefx.play("#loose")
			msg.post("manager#score", "update")
			wait.delay(1.5)
		end
	end
end