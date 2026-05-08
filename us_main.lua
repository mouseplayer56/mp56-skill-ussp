PlayerAction.UnseenStrike = {
	Priority = 1,
	Function = function (player_manager, min_time, max_duration, crit_chance)
		local co = coroutine.running()
		local target_time = Application:time() + min_time

		local function on_damage_taken()
			target_time = Application:time() + min_time
		end

		player_manager:register_message(Message.OnPlayerDamage, co, on_damage_taken)

		while Utils:IsInHeist() do
			if Application:time() >= target_time then
				managers.player:activate_temporary_upgrade("temporary", "unseen_strike")
			end

			if player_manager:has_activate_temporary_upgrade("temporary", "unseen_strike") then
                		on_damage_taken()
			end

			coroutine.yield(co)
		end

		player_manager:unregister_message(Message.OnPlayerDamage, co)
	end
}
