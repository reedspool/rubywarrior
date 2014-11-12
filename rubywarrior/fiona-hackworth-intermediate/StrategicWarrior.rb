load 'TacticalWarrior.rb'

class StrategicWarrior < TacticalWarrior
	def act!


		# find direction of captive
		# is there an enemy in that direction?
		# 	are all enemies bound?
		# 		attack_nearest
		# 	no?
		# 		bind nearest
		# no?
		# 	is there a captive in that direction?
		# 		save it
		# 	no?
		# 		walk towards captive


		

		# if feel(dir_to_captive).enemy?
		# 	if 
		# else 
		# 	if feel(dir_to_captive).captive?
		# 		rescue!(dir_to_captive)
		# 	else 
		# 		walk!(dir_to_captive)
		# 	end
		# end


	  	# Begin strategy
	  	if saving_captives_first
			unless captive_to_save.empty?
				rescue_captive!

				if touching_danger	
					bind_danger!

					dir = direction_of(captive_to_save.first)
				end

				attack_danger!

				dir = direction_of(captive_to_save.first)

				unless feel(dir).empty?
					return(walk!(empty))
				end

				return walk!(dir)
			end

			saving_captives_first = false;
	  	end

	  	if freeze_all_first
	  		if num_dangers > 0		
				bind_danger!

				dir = direction_of(danger_spaces.first)

				if dir == stairs
					return(walk!(empty))
				end

				return walk!(dir)
			end

			freeze_all_first = false;
	  	end

		attack_danger!
		
		return(rest!) if unfilled

		if num_captives > 0
			rescue_captive!

			dir = direction_of(captive_spaces.first)

			if dir == stairs
				return(walk!(empty))
			end

			return(walk!(direction_of(captive_spaces.first)))
		end

		if num_dangers > 0		
			bind_danger!

			dir = direction_of(danger_spaces.first)

			if dir == stairs
				return(walk!(empty))
			end

			return(walk!(dir))
		end

	  	walk! stairs
  	end
end