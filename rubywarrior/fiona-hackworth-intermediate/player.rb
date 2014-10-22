class Player

	@@max_health = 20
	@@dirs = [ :forward, :left, :backward, :right  ]
	@@freeze_all_first = true;

  def play_turn(warrior)

  	stairs = warrior.direction_of_stairs

		carry = Proc.new { |memo, a| a || memo }
		sum = Proc.new { |memo, a| (a ? 1 : 0) + memo }

		danger_map = @@dirs.map { |dir| 
			warrior.feel(dir).enemy? && dir 
		}

  	where_is_danger = danger_map.reduce &carry

  	num_dangers = danger_map.reduce(0, &sum)

		captive_map = @@dirs.map { |dir| 
			warrior.feel(dir).captive? && dir 
		}

		num_captives = captive_map.reduce(0, &sum)

  	where_is_captive = captive_map.reduce &carry

  	unfilled = warrior.health < @@max_health / 2

  	freezing = @@freeze_all_first && num_dangers > 0 

		return(warrior.bind!(where_is_danger)) if freezing

		@@freeze_all_first = false;

		return(warrior.attack!(where_is_danger)) if where_is_danger

		return(warrior.rest!) if unfilled

		return(warrior.rescue!(where_is_captive)) if where_is_captive

  	warrior.walk! stairs
  end
end
