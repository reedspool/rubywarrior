class Player

	@@max_health = 20
	@@dirs = [ :forward, :left, :backward, :right  ]

  def play_turn(warrior)

  	stairs = warrior.direction_of_stairs

  	danger = @@dirs.reduce(false) do |memo, dir|
  		
  		bad = warrior.feel(dir).enemy? && dir

  		bad || memo
  	end

  	should_really_rest = warrior.health < @@max_health

  	warrior.attack!(danger) && return if danger

  	warrior.rest! && return if should_really_rest

  	warrior.walk! stairs
  end
end
