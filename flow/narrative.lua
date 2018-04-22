-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local flow = require "flow.flow"

local narrative = {}

function narrative.single_message(text)
	msg.post("message_manager", "message", { text = text, notify = msg.url() })
	flow.until_message(hash "message_end")
end

function narrative.message_list(list)
	for key, value in pairs(list) do
		local notify = (not next(list, key)) and msg.url()
		msg.post("message_manager", "message", { text = value, notify = notify })
	end
	flow.until_message(hash "message_end")
end

function narrative.enable_player_control()
	msg.post("player", "acquire_input_focus")
end

function narrative.disable_player_control()
	msg.post("player", "release_input_focus")
end

return narrative
