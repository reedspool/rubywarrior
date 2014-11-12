load 'myWarrior.rb'

class SmartWarrior < MyWarrior
	attr_writer :freeze_all_enemies, :saving_captives_first

	def initialize(warrior)
		super warrior
	end

	def freeze_all_enemies
		@freeze_all_enemies || true
	end

	def saving_captives_first
		@saving_captives_first || true
	end

	def empty_map
		dirs.map do |dir|
			feel(dir).empty? && dir
		end
	end

	def stairs
		direction_of_stairs
	end

	def empty
		empty_map.reduce &carry
	end

	def danger_spaces
		danger_space_map.select(&identity)
	end

	def danger_space_map
		listen.map { |space| 
			space.enemy? && space 
		}
	end

	def num_dangers
		danger_space_map.reduce(0, &U.sum)
	end

	def touching_danger
		danger_map = dirs.map { |dir| 
			feel(dir).enemy? && dir 
		}

		danger_map.reduce &U.carry
	end

	def captive_space_map
		listen.map { |space| 
			space.captive? && space 
		}
	end

	def captive_map 
		dirs.map { |dir| 
			feel(dir).captive? && dir 
		}
	end

	def touching_captive
		captive_map.reduce &U.carry
	end

	def captive_spaces
		captive_space_map.select(&U.identity)
	end

	def captive_to_save
		captive_to_save_map = captive_spaces.map { |space|
			space.ticking? && space
		}

		captive_to_save_map.select(&U.identity)
	end

	def num_captives
		captive_space_map.reduce(0, &U.sum)
	end

	def dir_to_captive
		direction_of(captive_to_save.first)
	end

end