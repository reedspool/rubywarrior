class Player

	@@max_health = 20
	@@dirs = [ :forward, :left, :backward, :right  ]
	@@freeze_all_first = true

  def play_turn(warrior)

  	# Begin intense scanning

  	stairs = warrior.direction_of_stairs
  	units = warrior.listen

		carry = Proc.new { |memo, a| a || memo }
		sum = Proc.new { |memo, a| (a ? 1 : 0) + memo }
		identity = Proc.new { |a| a }

  	empty_map = @@dirs.map { |dir|
  		warrior.feel(dir).empty? && dir
  	}

  	empty = empty_map.reduce &carry

		danger_space_map = units.map { |space| 
			space.enemy? && space 
		}

		danger_map = @@dirs.map { |dir| 
			warrior.feel(dir).enemy? && dir 
		}

		touching_danger = danger_map.reduce &carry

  	danger_spaces = danger_space_map.select(&identity)

		num_dangers = danger_space_map.reduce(0, &sum)

		captive_space_map = units.map { |space| 
			space.captive? && space 
		}
		
		captive_map = @@dirs.map { |dir| 
			warrior.feel(dir).captive? && dir 
		}

		touching_captive = captive_map.reduce &carry

		captive_spaces = captive_space_map.select(&identity)

		num_captives = captive_space_map.reduce(0, &sum)

  	unfilled = warrior.health < @@max_health
  	
  	freeze = @@freeze_all_first && num_dangers > 0 

  	# Begin strategy

  	if @@freeze_all_first
  		if num_dangers > 0		
				return(warrior.bind!(touching_danger)) if touching_danger

				dir = warrior.direction_of(danger_spaces.first)

				if dir == stairs
					return(warrior.walk!(empty))
				end

				return(warrior.walk!(warrior.direction_of(danger_spaces.first)))
			end

			@@freeze_all_first = false;
  		return
  	end

puts num_dangers
  	# Begin strategy
		return(warrior.attack!(touching_danger)) if touching_danger

		return(warrior.rest!) if unfilled

		if num_captives > 0
			return(warrior.rescue!(touching_captive)) if touching_captive

			dir = warrior.direction_of(captive_spaces.first)

			if dir == stairs
				return(warrior.walk!(empty))
			end

			return(warrior.walk!(warrior.direction_of(captive_spaces.first)))
		end
		if num_dangers > 0		
			return(warrior.bind!(touching_danger)) if touching_danger

			dir = warrior.direction_of(danger_spaces.first)

			if dir == stairs
				return(warrior.walk!(empty))
			end

			return(warrior.walk!(dir))
		end

  	warrior.walk! stairs
  end
end
